require 'rails_helper'

describe DrugService do
  context "instance methods" do
    it "search_results" do
      adderall_search = File.read('spec/fixtures/adderall.json')
      
      stub_request(:get, "https://rxnav.nlm.nih.gov/REST/drugs.json?name=adderall").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: adderall_search, headers: {})

      expect(DrugService.new.search_results("adderall")).to be_a(Hash)
    end
  end
end