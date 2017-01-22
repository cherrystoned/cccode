require 'spec_helper'

describe Cccode do
  it 'has a version number' do
    expect(Cccode::VERSION).not_to be nil
  end

  describe 'class methods' do
  
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


