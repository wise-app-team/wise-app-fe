require 'rails_helper'

RSpec.describe 'Medical Index Page' do
  describe "As a visitor, when I visit /users/user_id/medical" do
    it "I see the name of the app at the top of the page & links to all pages" do
      visit '/users/1/medical'

      stub_request(:get, 'http://localhost:3000/api/v1/users/1/medical')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v2.7.4'
            }
          )
          .to_return(status: 200, body: [], headers: {})

      expect(page).to have_content("WiseApp")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Medical Page")
      # expect(page).to have_link("Social Page")
    end
  end
end