require 'rails'
require 'cccode/version'
require 'cccode/models/country_code'
require 'soap'

module Cccode
  
  def initialize
    
  end
  
  ### instance methods
  
  
  ### class methods
  # Cccode.get_countries
  def self.get_countries
    s = Soap.new
    s.countries
  end

  # Cccode.get_country_code('Spain')
  def self.get_country_code(country)
    s = Soap.new
    s.countries if Soap.table_empty?
    s.country_code(country)
  end

  def self.get_currency(country)
    s = Soap.new
    s.countries if Soap.table_empty?
    s.currency(country)
  end

  def self.get_currency_code(currency)
    s = Soap.new
    s.countries if Soap.table_empty?
    s.currency_code(currency)
  end
    
end
