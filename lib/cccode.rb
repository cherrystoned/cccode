require 'rails'
require 'cccode/version'
require 'cccode/models/country_code'
require 'soap'

module Cccode
  
  # database data
  class Codes
    
    attr_accessor :country, :country_code, :currency, :currency_code
  
    # Cccode::Codes.new('Germany')
    def initialize(country)
      record = Cccode::CountryCode.where(country: country).first
      if record
        @country          = record.country
        @country_code     = record.country_code
        @currency         = record.currency
        @currency_code    = record.currency_code
      end
    end
  end
  
  ## database actions
  # Cccode.reset
  def self.reset
    Cccode::CountryCode.destroy_all
  end

  # Cccode.get_all
  def self.get_all
    Cccode::CountryCode.destroy_all
    s = Soap.new(false)
    s.get_all
  end
  
  ## SOAP actions
  # Cccode.get_countries
  def self.get_countries
    s = Soap.new
    s.countries
  end

  # Cccode.get_country_code('Spain')
  def self.get_country_code(country)
    s = Soap.new
    s.country_code(country)
  end

  def self.get_currency(country)
    s = Soap.new
    s.currency(country)
  end

  def self.get_currency_code(currency)
    s = Soap.new
    s.currency_code(currency)
  end
    
end
