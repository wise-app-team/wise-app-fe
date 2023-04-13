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
        expect(page).to have_field(:name)
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

          fill_in :name, with: 'Pedro Pascal'
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

          expect(current_path).to eq('/dashboard')
          expect(page).to have_content('Welcome, Pedro Pascal!')
        end
      end

      describe 'when I enter invalid or missing information in the form' do
        it 'I am returned to the form and see a flash message indicating which field(s) I am missing' do
          visit '/users/new'

          fill_in :name, with: 'Quentin Tarantino'

          click_on "Submit"
        end
      end
    end
  end
end