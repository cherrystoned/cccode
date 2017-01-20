require 'rails'
require 'cccode/version'
require 'soap'
module Cccode
  
  # http://bamboolab.eu/blog/the-beginners-guide-to-crafting-ruby-gems
  #class Engine < ::Rails::Engine; end
  
  def initialize
    
  end
  
  def self.get_countries
    s = Soap.new
    s.countries
  end

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
