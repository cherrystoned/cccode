require 'spec_helper'

describe Cccode::Soap do
  
  describe 'savon errors' do
    it 'http error on call' do
      Cccode::Soap.const_set("WSDL", 'http://www.webservicex.net/countryerror.asmx?WSDL')
      s = Cccode::Soap.new
      s.send(:set_mode, :get_currency_code)
      expect{s.send(:call)}.to raise_error(RuntimeError)
      expect{s.send(:call)}.to raise_error('savon client error, call failed: 404')
    end
  end
  
end