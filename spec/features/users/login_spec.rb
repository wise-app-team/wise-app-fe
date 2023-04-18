require 'rails_helper'

RSpec.describe 'Login Page', type: :feature do 
  describe 'As a visitor to the login page' do      
      it 'I should see a form to login' do
        visit '/login'

      expect(page).to have_field("email")
      expect(page).to have_field("password")
      expect(page).to have_button("Login")
    end

    it 'I should be able to login with valid credentials' do
      visit '/login'

      user_info = "{\"data\":{\"id\":\"1\",\"type\":\"user\"}}"

      stub_request(:post, "http://localhost:5000/api/v1/users/login").
      with(
        body: {"email"=>"john@john.com", "password"=>"password"},
        headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type'=>'application/x-www-form-urlencoded',
              'User-Agent'=>'Faraday v2.7.4'
        }).to_return(status: 200, body: user_info, headers: {})

      fill_in :email, with: 'john@john.com'
      fill_in :password, with: 'password'
      
      click_button "Login"
      expect(current_path).to eq('/users/1')
    end
  end
end