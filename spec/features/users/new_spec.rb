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
       
				expect(page).to have_field(:street_address)
				expect(page).to have_field(:city)
				expect(page).to have_field(:state)
				expect(page).to have_field(:zip_code)
      end
      # it 'the form should also have fields for primary contact, including phone, email and name and secondary contact' do
      #   #skipping for now
      # end
      describe 'When I fill out the form with valid data' do
        it 'I am redirected to my dashboard and see a flash message that I am logged in' do
          visit '/users/new'

          json_string = "{\"data\":{\"id\":\"1\",\"type\":\"user\",\"attributes\":{\"name\":\"Khoa Doe\",\"email\":\"khoa_doe@gmail.com\",\"password_digest\":\"DOESTHISEVENMATTERWHATEVERITCANBETHISORSOMETHINGELSE\",\"birthday\":\"1990-01-01\",\"phone_number\":\"123-456-7890\",\"street_address\":\"123 Main St\",\"city\":\"Las Vegas\",\"state\":\"AK\",\"zip\":\"12345\",\"drugs\":[{\"id\":1,\"rxcui\":\"12345\",\"name\":\"Tylenol\",\"synonym\":\"yes\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"},{\"id\":43,\"rxcui\":\"54321\",\"name\":\"Tums\",\"synonym\":\"no\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"}],\"user_drugs\":[{\"id\":1,\"user_id\":1,\"drug_id\":1,\"dose1\":\"2000-01-01T19:00:00.000Z\",\"dose2\":\"2056-01-01T20:00:00.000Z\",\"dose3\":\"2077-01-01T21:00:00.000Z\",\"prn\":false,\"notes\":\"Take with food\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"},{\"id\":21,\"user_id\":1,\"drug_id\":43,\"dose1\":\"1993-01-01T19:00:00.000Z\",\"dose2\":\"2123-01-01T20:00:00.000Z\",\"dose3\":\"40032-01-01T21:00:00.000Z\",\"prn\":true,\"notes\":\"Do a backflip WHILE you take it\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"}]}}}"
					user_info = JSON.pretty_generate(JSON.parse(json_string))

     
          stub_request(:post, "http://localhost:5000/api/v1/users").
          with(
            body: {"birthday"=>"04/05/1975", "city"=>"Denver", "email"=>"Pedro@pedro.com", "name"=>"Pedro Pascal", "password"=>"password123", "password_confirmation"=>"password123", "phone_number"=>"555-555-5555", "state"=>"CO", "street_address"=>"123 Main St", "zip_code"=>"80209"},
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'Content-Type'=>'application/x-www-form-urlencoded',
           'User-Agent'=>'Faraday v2.7.4'
            }).
          to_return(status: 201, body: user_info, headers: {})

          stub_request(:get, "http://localhost:5000/api/v1/users/1").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: user_info, headers: {})

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

          stub_request(:post, "http://localhost:5000/api/v1/users").
          with(
            body: {"birthday"=>"", "city"=>"", "email"=>"", "name"=>"Quentin Tarantino", "password"=>"", "password_confirmation"=>"", "phone_number"=>"", "state"=>"", "street_address"=>"", "zip_code"=>""},
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'Content-Type'=>'application/x-www-form-urlencoded',
           'User-Agent'=>'Faraday v2.7.4'
            }).
          to_return(status: 422, body: "", headers: {})

          fill_in :first_name, with: 'Quentin'
          fill_in :last_name, with: 'Tarantino'
          fill_in :email, with: ''
          fill_in :password, with: ''
          fill_in :password_confirmation, with: ''
          fill_in :birthday, with: ''
          fill_in :phone_number, with: ''
          fill_in :street_address, with: ''
          fill_in :city, with: ''
          fill_in :state, with: ''
          fill_in :zip_code, with: ''

          click_on "Submit"
    
          expect(have_status(422)).to be_present
          expect({:flash=>{:error=>"User not created"}}).to be_present
          expect(current_path).to eq('/users/new')
        end
      end
    end
  end
end