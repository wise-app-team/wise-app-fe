require 'rails_helper'

RSpec.describe 'Medical Index Page' do
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
                    [{"id"=>1, 
                      "rxcui"=>"12345",
                      "name"=>"Tylenol", 
                      "synonym"=>"yes", 
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                      {"id"=>43, 
                        "rxcui"=>"54321",
                        "name"=>"Tums", 
                        "synonym"=>"no", 
                        "created_at"=>"2023-04-15T23:01:03.782Z",
                        "updated_at"=>"2023-04-15T23:01:03.782Z"}
                    ],
                    "user_drugs"=>
                    [{"id"=>1,
                      "user_id"=>1,
                      "drug_id"=>1,
                      "dose1"=>"2000-01-01T19:00:00.000Z",
                      "dose2"=>"2056-01-01T20:00:00.000Z",
                      "dose3"=>"2077-01-01T21:00:00.000Z",
                      "prn"=>false,
                      "notes"=>"Take with food",
                      "created_at"=>"2023-04-15T23:01:03.782Z",
                      "updated_at"=>"2023-04-15T23:01:03.782Z"},
                      {"id"=>21,
                        "user_id"=>1,
                        "drug_id"=>43,
                        "dose1"=>"1993-01-01T19:00:00.000Z",
                        "dose2"=>"2123-01-01T20:00:00.000Z",
                        "dose3"=>"40032-01-01T21:00:00.000Z",
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

         no_interactions = File.read('spec/fixtures/no_interactions.json')

         stub_request(:get, "https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=12345%2054321").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: "", headers: {})

         stub_request(:get, "http://localhost:5000/api/v1/find_by_rxcui?rxcui=1243440").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: "{\"data\":{\"id\":\"1\",\"type\":\"drug\"}}", headers: {})

      visit '/users/1/meds'
    end

    it "I see the name of the app at the top of the page & links to all pages" do
      expect(page).to have_content("WiseApp")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("MyMeds")
    end

    it "I see a list of all medications I am currently taking" do
      expect(page).to have_content("Current Medications")

      within "#medication-1" do
        expect(page).to have_content("Name: Tylenol")
        expect(page).to have_content("Dose 1: 2000-01-01T19:00:00.000Z")
        expect(page).to have_content("Dose 2: 2056-01-01T20:00:00.000Z")
        expect(page).to have_content("Dose 3: 2077-01-01T21:00:00.000Z")
        expect(page).to have_content("As Needed: false")
        expect(page).to have_content("Notes: Take with food")
      end

      within "#medication-43" do
        expect(page).to have_content("Name: Tums")
        expect(page).to have_content("Dose 1: 1993-01-01T19:00:00.000Z")
        expect(page).to have_content("Dose 2: 2123-01-01T20:00:00.000Z")
        expect(page).to have_content("Dose 3: 40032-01-01T21:00:00.000Z")
        expect(page).to have_content("As Needed: true")
        expect(page).to have_content("Notes: Do a backflip WHILE you take it")
      end
    end

    xit "I see an edit link next to each medication, clicking it, I am taken to a form, with the values correctly filled." do
      within "#medication-1" do
        expect(page).to have_link("Edit")
        click_on "Edit"  
      end

      expect(current_path).to eq("/users/1/meds/1/edit")

      expect(page).to have_field('dose1', with: '2000-01-01T19:00:00.000Z')
      expect(page).to have_field('dose2', with: '2056-01-01T20:00:00.000Z')
      expect(page).to have_field('dose3', with: '2077-01-01T21:00:00.000Z')
      expect(page).to have_checked_field('prn', with: 'false')
      expect(page).to have_field('notes', with: 'Take with food')
    end

    xit "I see a delete link next to each mdeication, clicking it, I am returned to '/users/user_id/meds' and see that the deleted medication is no longer present" do
      within "#medication-1" do
        expect(page).to have_content("Name: Tylenol")
        expect(page).to have_content("Dose 1: 2000-01-01T19:00:00.000Z")
        expect(page).to have_content("Dose 2: 2056-01-01T20:00:00.000Z")
        expect(page).to have_content("Dose 3: 2077-01-01T21:00:00.000Z")
        expect(page).to have_content("As Needed: false")
        expect(page).to have_content("Notes: Take with food")
        expect(page).to have_link("Delete")

        click_on "Delete"  
      end

      expect(current_path).to eq("/users/1/meds")

      # expect(page).to_not have_content("Name: Tylenol")
      # expect(page).to_not have_content("Dose 1: 2000-01-01T19:00:00.000Z")
      # expect(page).to_not have_content("Dose 2: 2056-01-01T20:00:00.000Z")
      # expect(page).to_not have_content("Dose 3: 2077-01-01T21:00:00.000Z")
      # expect(page).to_not have_content("As Needed: false")
      # expect(page).to_not have_content("Notes: Take with food")
      # expect(page).to_not have_link("Edit")
      # expect(page).to_not have_link("Delete")
    end

    it "shows 'No interactions found' if there are no interactions" do
      expect(page).to have_content("Interactions:")
      
      within "#interactions" do
        expect(page).to have_content("No interactions found.")
      end
    end
    it "I see a list of medications I have searched for" do
      stub_request(:post, "http://localhost:5000/api/v1/drugs").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: "", headers: {})
          
         fill_in :search, with: "Tylenol"
        click_on "Submit"
    
         expect(page).to have_content("Medications Searched")
    
        within "#meds-searched" do
          expect(page).to have_content("Tylenol", count: 8)
          expect(page).to have_button("Add", count: 8)
        end
    
        within "#medication-1243440" do
          expect(page).to have_button("Add")
          click_on "Add"
        end        
    
      expect(current_path).to eq("/users/1/meds/new")
    
      expect(page).to have_content("Add a medication to your list")
      expect(page).to have_field(:dose1)
      expect(page).to have_field(:dose2)
      expect(page).to have_field(:dose3)
      expect(page).to have_field(:prn)
      expect(page).to have_field(:notes)
    end
    
    it 'I can add info to the medication and when I click submit, I am redirected back to my meds page, where I see the new medication added' do
      data = "{\"data\":{\"id\":\"1\",\"type\":\"drug\"}}"
    
      stub_request(:post, "http://localhost:5000/api/v1/drugs").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Content-Type'=>'application/x-www-form-urlencoded',
       'User-Agent'=>'Faraday v2.7.4'
        }).to_return(status: 200, body: data.to_json, headers: {})
        
        stub_request(:post, "http://localhost:5000/api/v1/user_drugs").
        with(
          body: {"dose1"=>"2000-01-01T19:00:00.000Z", "dose2"=>"2056-01-01T20:00:00.000Z", "dose3"=>"2077-01-01T21:00:00.000Z", "drug_id"=>"1", "notes"=>"Take it while holding a frog", "prn"=>"true", "user_id"=>"1"},
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Content-Type'=>'application/x-www-form-urlencoded',
         'User-Agent'=>'Faraday v2.7.4'
          }).to_return(status: 200, body: "", headers: {})
    
        drug_body = "{\"data\":{\"id\":\"1\",\"type\":\"drug\"}}"
    
      stub_request(:get, "http://localhost:5000/api/v1/find_by_rxcui/").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.7.4'
        }).
      to_return(status: 200, body: drug_body, headers: {})
        
      fill_in :search, with: "Tylenol"
      click_on "Submit"
    
      within "#medication-1243440" do
        click_on "Add"
      end        
    
      expect(current_path).to eq("/users/1/meds/new")
      fill_in :dose1, with: "2000-01-01T19:00:00.000Z"
      fill_in :dose2, with: "2056-01-01T20:00:00.000Z"
      fill_in :dose3, with: "2077-01-01T21:00:00.000Z"
      choose :prn_true
      fill_in :notes, with: "Take it while holding a frog"
      
      click_on 'Submit'
    
      expect(current_path).to eq("/users/1/meds")
    end
  end
end

