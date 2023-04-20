require 'rails_helper'

RSpec.describe 'User Show Page' do
  describe "As a visitor, when I visit /users/user_id" do
    it "I see the name of the app at the top of the page & links to all pages" do
      visit '/users/1'

      stub_request(:post, "http://localhost:5000/api/v1/users").
      with(
        body: {"birthday"=>"04/05/1975", "email"=>"Pedro@pedro.com", "first_name"=>"Pedro", "last_name"=>"Pascal", "password"=>"password123", "password_confirmation"=>"password123", "phone_number"=>"555-555-5555", "street_address"=>"123 Main St", "city"=>"Denver", "state"=>"CO", "zip_code"=>"80209"},
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Content-Type'=>'application/x-www-form-urlencoded',
       'User-Agent'=>'Faraday v2.7.4'
        }).
      to_return(status: 201, body: "", headers: {})

      expect(page).to have_content("WiseApp")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("MyMeds")
    end
  end
end