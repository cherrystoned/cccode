class Cccode::Soap

  require 'pry'
  require 'Savon'
  require 'active_support/core_ext/object/try'
  
  WSDL = 'http://www.webservicex.net/country.asmx?WSDL'
  
  attr_accessor :client, :countries, :response, :result, :xml,
                :command, :result_keys, :message,
                :country_code, :country, :currency, :currency_code
  
  def initialize
    @country  = 'Germany'
    @currency = 'de'
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
    begin
      # todo: database
      get_xml(:get_countries)
      @countries = @xml.css('Table').map{|e| e.content.strip}
      #Country.insert_countries(@countries)
    rescue Savon::Error => e
      puts e.inspect
      nil
    end
  end

  def country_code(country=nil)
    @country = country if country
    # todo: database
    get_xml(:get_iso_country_code_by_county_name)
    @country_code = @xml.css('Table/CountryCode').first.content
    #Country.insert_country_code(@country_code)
  end

  def currency(country=nil)
    @country = country if country
    # todo: database
    get_xml(:get_currency_by_country)
    @country_code = @xml.css('Table/CountryCode').first.content
    #Country.insert_country_code(@country_code)
  end

  def currency_code(currency=nil)
    @currency = currency if currency
    # todo: database
    get_xml(:get_currency_code_by_currency_name)
    @currency_code = @xml.css('Table/CurrencyCode').first.content
    #Country.insert_country_code(@country_code)
  end
  
  private
  
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
    binding.pry
    @response = self.client.call(@command, :message => @message)
  end
  
  def result
    @result = nested_keys(@response.hash, *@result_keys)
    @xml = Nokogiri::XML(@result)
  end
  
  
  # todo: move to lib
  def nested_keys(source_hash, *target_keys)
    begin
      new_keys = target_keys
      new_hash = source_hash
      while new_keys.present?
        return nil unless valid_key?(new_keys[0], new_hash)
        
        chk_try = new_hash.try(:[], new_keys[0])
        if chk_try
          new_hash = new_hash[new_keys[0]]
          new_keys.delete_at(0)
          return chk_try   if new_keys.blank?
        else
          return nil
        end
      end   if new_keys && new_hash
      new_hash
    rescue StandardError => e
      return nil
    end
  end
  
  def valid_key?(k, source=nil)
    key_valid = k.is_a?(String) || k.is_a?(Integer) || k.is_a?(Symbol)
    ar_valid  = source ? (source.is_a?(Array) ? k.is_a?(Integer) : true) : true
    key_valid && ar_valid
  end

end