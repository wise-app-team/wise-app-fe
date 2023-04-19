require 'rails_helper'

RSpec.describe 'User Show Page' do
  describe "As a visitor, when I visit /users/user_id" do
    before do
      user_data = {
        id: 1,
        type: 'user',
        attributes: {
          name: 'John Doe',
          email: 'john@john.com',
          provider: nil,
          token: nil,
          password_digest: '$2a$04$OrtXfsglYyJG322eUYyoR.7td4Za/IN2gUlw1uiBx5.vdAEh4fLXi',
          birthday: '1999-01-01',
          phone_number: '1234567890',
          street_address: '123 Main St',
          city: 'Denver',
          state: 'NY',
          zip_code: '12345',
          drugs: [],
          user_drugs: []
        }
      }
      stub_request(:get, "http://localhost:5000/api/v1/users/1").
        to_return(status: 200, body: { data: user_data }.to_json)
      stub_request(:get, "http://localhost:5000/api/v1/users").
        to_return(status: 200, body: { data: [user_data] }.to_json)
    end
    
    it "I see the name of the app at the top of the page & links to all pages" do
      visit '/users/1'
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('MyMeds')
      expect(page).to have_content("Welcome John Doe")
    end
  end
end
