require 'spec_helper'

describe Cccode do
  
  it 'has a version number' do
    expect(Cccode::VERSION).not_to be nil
  end

  describe 'fill the country_codes table' do
    
    Cccode.get_all
    it 'database is filled' do
      expect(Cccode::CountryCode.exists?).to be true
      expect(Cccode::CountryCode.count).to eq 244
    end
    
    subject { Cccode::CountryCode.where(country: 'Greece').first }
    it 'Greece data complete present' do
      expect(subject.country_code).to eq 'gr'
      expect(subject.currency).to eq 'Drachma'
      expect(subject.currency_code).to eq 'GRD'
    end
  end
  
  describe 'Cccode::Codes' do
  
    describe 'Cccode::Codes#new' do
      it 'get all data for France' do
        
        obj = Cccode::Codes.new('France')
        expect(obj.class).to eq Cccode::Codes
        expect(obj.country).to eq 'France'
        expect(obj.country_code).to eq 'fr'
        expect(obj.currency).to eq 'Franc'
        expect(obj.currency_code).to eq 'FRF'
      end
    end
  end
  
  describe 'class methods' do
  
    context 'database' do
      describe 'Cccode#reset' do
        it 'reset table' do
          Cccode.reset
          expect(Cccode::CountryCode.count).to eq 0
        end
      end
    end

    context 'SOAP data' do
    
      describe 'Cccode#get_countries' do
        it 'get 244 countries' do
          expect(Cccode.get_countries.size).to eq 244
        end
      end
  
      describe 'Cccode#get_country_code' do
        it 'country code Germany is \'de\'' do
          expect(Cccode.get_country_code('Germany')).to eq 'de'
        end
      end
  
      describe 'Cccode#get_currency' do
        it 'currency Germany is \'Mark\'' do
          expect(Cccode.get_currency('Germany')).to eq 'Mark'
        end
      end
  
      describe 'Cccode#get_currency_code' do
        it 'currency code Mark is \'DEM\'' do
          expect(Cccode.get_currency_code('Mark')).to eq 'DEM'
        end
      end
      
    end

  end
  
end


