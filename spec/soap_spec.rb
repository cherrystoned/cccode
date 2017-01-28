require 'spec_helper'

describe Cccode::Soap do
  
  describe 'savon errors' do
    
    before do
      Cccode::Soap.const_set("WSDL", 'http://www.webservicex.net/countryerror.asmx?WSDL')
    end

    context '#call' do
      it 'http error on call' do
        s = Cccode::Soap.new
        s.send(:set_mode, :get_currency_code)
        expect{s.send(:call)}.to raise_error(RuntimeError)
        expect{s.send(:call)}.to raise_error('savon call error, call failed: 404')
      end
    end
    
  end
end
