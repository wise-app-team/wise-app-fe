require 'rails_helper'

RSpec.describe 'Medical Interactions on Index Page' do
  describe "As a visitor, when I visit /users/user_id/meds" do
    before do
      data = {"data"=>
                {"id"=>"1",
                 "type"=>"user",
                 "attributes"=>
                  {"name"=>"Khoa Doe",
                   "email"=>"khoa_doe@gmail.com",
                   "password_digest"=>"DOESTHISEVENMATTERWHATEVERITCANBETHISORSOMETHINGELSE",
                   "birthday"=>"1990-01-01",
                   "phone_number"=>"123-456-7890",
                   "street_address"=>"123 Main St",
                   "city"=>"Las Vegas",
                   "state"=>"AK",
                   "zip"=>"12345",
                   "drugs"=>
                    [{"id"=>42, 
                      "rxcui"=>"207106",
                      "name"=>"fluconazole 50 MG Oral Tablet [Diflucan]", 
                      "synonym"=>"yes", 
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                     {"id"=>51, 
                      "rxcui"=>"152923",
                      "name"=>"simvastatin 40 MG Oral Tablet [Zocor]", 
                      "synonym"=>"no", 
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                     {"id"=>67, 
                      "rxcui"=>"656659",
                      "name"=>"bosentan 125 MG Oral Tablet", 
                      "synonym"=>"no", 
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                     {"id"=>3, 
                      "rxcui"=>"209459",
                      "name"=>"acetaminophen 500 MG Oral Tablet [Tylenol]", 
                      "synonym"=>"no", 
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                            "updated_at"=>"2023-04-15T23:01:03.782Z"}
                    ],
                    "user_drugs"=>
                    [{"id"=>1,
                      "user_id"=>1,
                      "drug_id"=>42,
                      "dose1"=>"2000-01-01T19:00:00.000Z",
                      "dose2"=>"2056-01-01T20:00:00.000Z",
                      "dose3"=>"2077-01-01T21:00:00.000Z",
                      "prn"=>false,
                      "notes"=>"Take with food",
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                     {"id"=>21,
                      "user_id"=>1,
                      "drug_id"=>51,
                      "dose1"=>"1783-01-01T19:00:00.000Z",
                      "dose2"=>"2091-01-01T20:00:00.000Z",
                      "dose3"=>"12345-01-01T21:00:00.000Z",
                      "prn"=>true,
                      "notes"=>"Do a backflip WHILE you take it",
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                     {"id"=>98,
                      "user_id"=>1,
                      "drug_id"=>67,
                      "dose1"=>"321-01-01T19:00:00.000Z",
                      "dose2"=>"1089-01-01T20:00:00.000Z",
                      "dose3"=>"2006-01-01T21:00:00.000Z",
                      "prn"=>true,
                      "notes"=>"Do a backflip WHILE you take it",
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                     {"id"=>72,
                      "user_id"=>1,
                      "drug_id"=>3,
                      "dose1"=>"245-01-01T19:00:00.000Z",
                      "dose2"=>"2016-01-01T20:00:00.000Z",
                      "dose3"=>"3025-01-01T21:00:00.000Z",
                      "prn"=>true,
                      "notes"=>"Do a backflip WHILE you take it",
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"}
                    ]
                  }
                }
            }
            
            drugs_searched = File.read('spec/fixtures/tylenol.json')

            stub_request(:get, "http://localhost:5000/api/v1/users/1").
            with(
              headers: {
             'Accept'=>'*/*',
             'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'User-Agent'=>'Faraday v2.7.4'
              }).
            to_return(status: 200, body: data.to_json, headers: {})

            stub_request(:delete, "http://localhost:5000/api/v1/user_drugs/1").
            with(
              headers: {
             'Accept'=>'*/*',
             'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'User-Agent'=>'Faraday v2.7.4'
              }).to_return(status: 200, body: data.to_json, headers: {})

            stub_request(:get, "https://rxnav.nlm.nih.gov/REST/drugs.json?name=Tylenol").
            with(
              headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.7.4'
              }).
            to_return(status: 200, body: drugs_searched, headers: {})

            stub_request(:get, "https://rxnav.nlm.nih.gov/REST/drugs.json?name=").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: drugs_searched, headers: {})

         interactions = File.read('spec/fixtures/interactions.json')

        stub_request(:get, "https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=207106%20152923%20656659%20209459").
          with(
            headers: 
              {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v2.7.4'
              }).to_return(status: 200, body: interactions, headers: {})


        stub_request(:get, "https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=").
          with(
            headers: 
              {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v2.7.4'
              }
            ).to_return(status: 200, body: interactions, headers: {})

      visit '/users/1/meds'
    end

    it "I see a list of all medications I am currently taking" do
      expect(current_path).to eq("/users/1/meds")
      expect(page).to have_content("Current Medications")

      within "#medication-42" do
        expect(page).to have_content("Name: fluconazole 50 MG Oral Tablet [Diflucan]")
        expect(page).to have_content("Dose 1: 2000-01-01T19:00:00.000Z")
      end

      within "#medication-51" do
        expect(page).to have_content("Name: simvastatin 40 MG Oral Tablet [Zocor]")
        expect(page).to have_content("Dose 1: 1783-01-01T19:00:00.000Z")
      end

      within "#medication-67" do
        expect(page).to have_content("Name: bosentan 125 MG Oral Tablet")
        expect(page).to have_content("Dose 1: 321-01-01T19:00:00.000Z")
      end

      within "#medication-3" do
        expect(page).to have_content("Name: acetaminophen 500 MG Oral Tablet [Tylenol]")
        expect(page).to have_content("Dose 1: 245-01-01T19:00:00.000Z")
      end
    end

    it "I see a list of drug interactions" do
      expect(page).to have_content("Interactions:")
      
      within "#interactions" do
        expect(page).to have_content("The metabolism of Simvastatin can be decreased when combined with Fluconazole.")
        expect(page).to have_content("The serum concentration of Simvastatin can be decreased when it is combined with Bosentan.")
        expect(page).to have_content("The metabolism of Bosentan can be decreased when combined with Fluconazole.")
        expect(page).to have_content("The metabolism of Simvastatin can be decreased when combined with Acetaminophen.")
        expect(page).to have_content("The metabolism of Acetaminophen can be decreased when combined with Fluconazole.")
        expect(page).to have_content("HMG Co-A reductase inhibitors - CYP3A4 inhibitors")
      end
    end
  end
end