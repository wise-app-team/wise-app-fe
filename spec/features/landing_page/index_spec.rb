require 'rails_helper'

RSpec.describe 'Landing Page', type: :feature do
  describe 'as a visitor to the langing page' do
    it 'should show the name of the app at the top of the page' do
      visit '/'

      expect(page).to have_content('Welcome to WiseApp')
      expect(page).to have_link('Login Here')
      expect(page).to have_link('Create Account')
    end

    # describe 'I see an area to search for resources based on my zip code' do
    #   it 'I see a list of the first five agencies listed for my zip code' do
    #     visit '/'

    #     fill_in :zip_code, with: '80209'

    #     click_on 'Search'

    #     expect(current_path).to eq('/search')
    #     expect(page).to have_content('First Five Agencies')
    #   end
    # end
  end
end