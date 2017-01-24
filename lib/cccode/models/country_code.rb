require 'active_record'

module Cccode
  class CountryCode < ActiveRecord::Base

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
    
  end
end