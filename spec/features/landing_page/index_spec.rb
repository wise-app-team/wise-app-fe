require 'rails_helper'

RSpec.describe 'Landing Page', type: :feature do
  describe 'as a visitor to the langing page' do
    it 'should show the name of the app at the top of the page' do
      visit '/'

      expect(page).to have_content('Welcome to WiseApp')
      expect(page).to have_link('Login Here')
      expect(page).to have_link('Create Account')
    end
  end
end