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
                      "updated_at"=>"2023-04-15T23:01:03.782Z"}
                    ]
                  }
                }
            }
            

            stub_request(:get, "http://localhost:3000/api/v1/users/1").
            with(
              headers: {
             'Accept'=>'*/*',
             'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'User-Agent'=>'Faraday v2.7.4'
              }).
            to_return(status: 200, body: data.to_json, headers: {})

      visit '/users/1/meds'
    end

    it "I see the name of the app at the top of the page & links to all pages" do
      expect(page).to have_content("WiseApp")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Medical Page")
    end

    xit "can search for a medication" do
      expect(page).to have_content("Search for Medication to add to list")
      expect(page).to have_button("Submit")

      fill_in :search, with: "Tylenol"
      click_on "Submit"

      expect(current_path).to eq("/users/1/meds")
    end

    it "I see a list of all medications I am currently taking" do
      expect(page).to have_content("Current Medications")
      expect(page).to have_content("Name: Tylenol")
      expect(page).to have_content("Dose 1: 2000-01-01T19:00:00.000Z")
      expect(page).to have_content("Dose 2: 2056-01-01T20:00:00.000Z")
      expect(page).to have_content("Dose 3: 2077-01-01T21:00:00.000Z")
      expect(page).to have_content("As Needed: false")
      expect(page).to have_content("Notes: Take with food")
    end

    it "I see an edit link next to each medication" do
      within "#medication-1" do
        expect(page).to have_link("Edit")
        click_on "Edit"

        expect(current_path).to eq("/users/1/meds/1/edit")

        save_and_open_page
      end
    end
  end
end