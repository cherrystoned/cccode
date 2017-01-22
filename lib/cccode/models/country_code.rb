module Cccode
  class CountryCode < ActiveRecord::Base
    
    def self.countries
      CountryCode.pluck(:country)
    end

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
    
  end
 
end