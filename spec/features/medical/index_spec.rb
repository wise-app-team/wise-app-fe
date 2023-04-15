require 'rails_helper'

RSpec.describe 'Medical Index Page' do
  describe "As a visitor, when I visit /users/user_id/medical" do
    before do
      visit '/users/1/medical'

      stub_request(:get, "http://localhost:3000/api/v1/users/1/medical").with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
        }).to_return(status: 200, body: "", headers: {})
    end

    it "I see the name of the app at the top of the page & links to all pages" do
      expect(page).to have_content("WiseApp")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Medical Page")
      # expect(page).to have_link("Social Page")
    end

    it "can search for a medication" do
      expect(page).to have_content("Search for Medication to add to list")
      expect(page).to have_button("Submit")

      fill_in :search, with: "Tylenol"
      click_on "Submit"

      expect(current_path).to eq("/users/1/medical")
    end

    it "I see a list of all medications I am currently taking" do
      expect(page).to have_content("Current Medications")
      expect(page).to have_content("Name: Tylenol")
      expect(page).to have_content("Dose 1: 8:00AM")
      expect(page).to have_content("Dose 2: 12:00PM")
      expect(page).to have_content("Dose 3: 4:00PM")
      expect(page).to have_content("As Needed: true")
      expect(page).to have_content("Notes: Take with food")
    end

    xit "I see an edit button next to each medication" do
      within "#medication-1" do
        expect(page).to have_button("Edit")
      end
    end
  end
end