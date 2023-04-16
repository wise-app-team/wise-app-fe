require 'rails_helper'

RSpec.describe 'New User' do
  describe 'As a visitor' do
    describe 'When I visit the new user registration page (/users/new)' do
      before :each do
        visit '/'
        click_on 'Create Account'
      end
      it 'show a form to create an account with name, email, password, password confirmation, birthday, phone number, and address fields' do

        expect(current_path).to eq('/users/new')
        expect(page).to have_content('Welcome to WiseApp')
        expect(page).to have_content("Create Account below to get started!")
        expect(page).to have_field(:first_name)
        expect(page).to have_field(:last_name)
        expect(page).to have_field(:email)
        expect(page).to have_field(:password)
        expect(page).to have_field(:password_confirmation)
        expect(page).to have_field(:birthday)
        expect(page).to have_field(:phone_number)
        within '.address' do
          expect(page).to have_field(:street_address)
          expect(page).to have_field(:city)
          expect(page).to have_field(:state)
          expect(page).to have_field(:zip_code)
        end
      end
      # it 'the form should also have fields for primary contact, including phone, email and name and secondary contact' do
      #   #skipping for now
      # end
      describe 'When I fill out the form with valid data' do
        it 'I am redirected to my dashboard and see a flash message that I am logged in' do
          visit '/users/new'

          user_info = "{\"data\":{\"id\":\"1\",\"type\":\"user\"}}"

          stub_request(:post, "http://localhost:3000/api/v1/users").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Length'=>'0',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 201, body: user_info, headers: {})

          fill_in :first_name, with: 'Pedro'
          fill_in :last_name, with: 'Pascal'
          fill_in :email, with: 'Pedro@pedro.com'
          fill_in :password, with: 'password123'
          fill_in :password_confirmation, with: 'password123'
          fill_in :birthday, with: '04/05/1975'
          fill_in :phone_number, with: '555-555-5555'
          fill_in :street_address, with: '123 Main St'
          fill_in :city, with: 'Denver'
          fill_in :state, with: 'CO'
          fill_in :zip_code, with: '80209'

          click_on 'Submit'

          expect(current_path).to eq("/users/1")
        end
      end

      describe 'when I enter invalid or missing information in the form' do
        it 'I am returned to the form and see a flash message indicating which field(s) I am missing' do
          visit '/users/new'

          stub_request(:post, "http://localhost:3000/api/v1/users").
          with(
            body: {"birthday"=>"", "email"=>"", "first_name"=>"Quentin", "last_name"=>"Tarantino", "password"=>"", "password_confirmation"=>"", "phone_number"=>""},
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'Content-Type'=>'application/x-www-form-urlencoded',
           'User-Agent'=>'Faraday v2.7.4'
            }).
          to_return(status: 400, body: "Error: User not created", headers: {})

          fill_in :first_name, with: 'Quentin'
          fill_in :last_name, with: 'Tarantino'

          click_on "Submit"
          
          expect(current_path).to eq('/users/new')
          expect(response.body).to match(/ERROR: User not created/)
        end
      end
    end
  end
end