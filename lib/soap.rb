class Cccode::Soap

  require 'pry'
  require 'savon'
  require 'misc'
    
  WSDL = 'http://www.webservicex.net/country.asmx?WSDL'
  
  attr_accessor :client, :countries, :response, :result, :xml,
                :command, :result_keys, :message,
                :country_code, :country, :currency, :currency_code,
                :currencies
  
  def initialize(get_countries=true)
    #self.get_all if get_countries && table_empty?
  end

  # todo: needed here? only model direct?
  def table_empty?
    Cccode::Soap.table_empty?
  end
  
  def self.table_empty?
    !Cccode::CountryCode.exists?
  end
  
  def client
    begin
      @client ||= Savon.client(wsdl: WSDL)
      # todo: error handling, tests!
    rescue Savon::Error => e
      puts e.inspect
      nil
    end
  end

  def get_all
    get_xml(:get_currency_code)
    Cccode::CountryCode.insert_all(@xml)
  end
  
  def countries
    get_xml(:get_countries)
    @countries = @xml.css('Table').map{|e| e.content.strip}
  end
  
  def country_code(country=nil)
    @country = country if country
    get_xml(:get_iso_country_code_by_county_name)
    @country_code = get_content('Table/CountryCode')
  end

  def currency(country=nil)
    @country = country if country
    get_xml(:get_currency_by_country)
    @currency = get_content('Table/Currency')
  end

  def currency_code(currency=nil)
    @currency = currency if currency
    get_xml(:get_currency_code_by_currency_name)
    @currency_code = get_content('Table/CurrencyCode')
  end
  
  private
  
  def get_content(css)
    @xml.css(css).first.present? ? @xml.css(css).first.content : nil
  end
  
  def set_mode(mode)
    @command = mode
    @message = nil
    case mode
      when :get_countries
        @result_keys = [
          :envelope, :body, :get_countries_response, :get_countries_result
        ]
      when :get_iso_country_code_by_county_name
        @result_keys = [
          :envelope, :body, :get_iso_country_code_by_county_name_response,
          :get_iso_country_code_by_county_name_result
        ]
        @message = {"CountryName" => @country}
      when :get_currency_by_country
        @result_keys = [
          :envelope, :body, :get_currency_by_country_response,
          :get_currency_by_country_result
        ]
        @message = {"CountryName" => @country}
      when :get_currency_code_by_currency_name
        @result_keys = [
          :envelope, :body, :get_currency_code_by_currency_name_response,
          :get_currency_code_by_currency_name_result
        ]
        @message = {"CurrencyName" => @currency}
      when :get_currency_code
        @result_keys = [
          :envelope, :body, :get_currency_code_response,
          :get_currency_code_result
        ]
    end
  end
  
  def get_xml(mode)
    set_mode(mode)
    call
    result
  end
  
  def call
    begin
      @response = self.client.call(@command, :message => @message)
    rescue Savon::HTTPError => e
      raise "savon client error, call failed: #{e.http.code}"
    end
  end
  
  def result
    @result = Cccode::Misc.nested_keys(@response.hash, *@result_keys)
    @xml = Nokogiri::XML(@result)
  end

end