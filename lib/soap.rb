class Cccode::Soap

  require 'pry'
  require 'Savon'
  require 'misc'
    
  WSDL = 'http://www.webservicex.net/country.asmx?WSDL'
  
  attr_accessor :client, :countries, :response, :result, :xml,
                :command, :result_keys, :message,
                :country_code, :country, :currency, :currency_code
  
  def initialize
    @country  = 'Germany'
    @currency = 'Mark'
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

  def countries
    @countries = Cccode::CountryCode.countries
    return @countries if @countries.present?
    get_xml(:get_countries)
    @countries = @xml.css('Table').map{|e| e.content.strip}
    Cccode::CountryCode.insert_countries(@countries)
    @countries
  end
  
  def country_code(country=nil)
    @country = country if country
    @country_code = Cccode::CountryCode.get_country_code(@country)
    return @country_code if @country_code.present?
    get_xml(:get_iso_country_code_by_county_name)
    @country_code = get_content('Table/CountryCode')
    Cccode::CountryCode.insert_country_code(@country, @country_code)
    @country_code
  end

  def currency(country=nil)
    @country = country if country
    @currency = Cccode::CountryCode.get_currency(@country)
    return @currency if @currency.present?
    get_xml(:get_currency_by_country)
    @currency = get_content('Table/Currency')
    Cccode::CountryCode.insert_currency(@country, @currency)
    @currency
  end

  def currency_code(currency=nil)
    @currency = currency if currency
    @currency_code = Cccode::CountryCode.get_currency_code(@currency)
    return @currency_code if @currency_code.present?
    get_xml(:get_currency_code_by_currency_name)
    @currency_code = get_content('Table/CurrencyCode')
    Cccode::CountryCode.insert_currency_code(@currency, @currency_code)
    @currency_code
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
    end
  end
  
  def get_xml(mode)
    set_mode(mode)
    call
    result
  end
  
  def call
    @response = self.client.call(@command, :message => @message)
  end
  
  def result
    @result = Cccode::Misc.nested_keys(@response.hash, *@result_keys)
    @xml = Nokogiri::XML(@result)
  end

end