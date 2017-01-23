require 'active_record'

module Cccode
  class CountryCode < ActiveRecord::Base
    
    # get
    # def self.countries
    #   CountryCode.pluck(:country)
    # end

    def self.insert_all(xml)
      xml.css('Table').each_with_index do |_, idx|
        CountryCode.create(
          country: xml.css('Table/Name')[idx].text.strip,
          country_code: xml.css('Table/CountryCode')[idx].text.strip,
          currency: xml.css('Table/Currency')[idx].text.strip,
          currency_code: xml.css('Table/CurrencyCode')[idx].text.strip,
        )
      end
      true
    end
    
=begin
    def self.currencies
      countries = CountryCode.all
      countries.each do |country|
        return nil if country.country_code.blank? ||
          country.currency.blank? ||
          country.currency_code.blank?
      end
      countries
    end
    
    def self.get_country_code(country)
      rec = CountryCode.where(country: country).first
      rec ? rec.country_code : nil
    end

    def self.get_currency(country)
      rec = CountryCode.where(country: country).first
      rec ? rec.currency : nil
    end

    def self.get_currency_code(currency)
      rec = CountryCode.where(currency: currency).first
      rec ? rec.currency_code : nil
    end
=end
    
    
    # inserts & updates
=begin
    def self.insert_countries(countries)
      return if countries.blank?
      CountryCode.destroy_all
      countries.map do |country|
        next if country.blank?
        CountryCode.create(
          country: country.strip,
        )
      end
    end
    
    def self.insert_country_code(country, country_code)
      rec = CountryCode.where(country: country).first
      rec.update(country_code: country_code) if rec
    end

    def self.insert_currency(country, currency)
      rec = CountryCode.where(country: country).first
      rec.update(currency: currency) if rec
    end

    def self.insert_currency_code(currency, currency_code)
      rec = CountryCode.where(currency: currency).first
      rec.update(currency_code: currency_code) if rec
    end
=end
    
  end
 
end