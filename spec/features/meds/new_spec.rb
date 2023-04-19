# require 'rails_helper'

# RSpec.describe 'Medical new Page' do
#   describe 'when a user visits the new med page' do
#     it 'can see a form to add the medication' do
      
#       visit '/users/1/meds'

#       fill_in :search, with: "Tylenol"
#       click_on "Submit"

#       within "#meds-searched" do
#         first(:link, "Add").click
#         expect(current_path).to eq("/users/1/meds/new")
#       end
      
#       expect(page).to have_content("Add Medication")
#       expect(page).to have_field(:dose1)
#       expect(page).to have_field(:dose2)
#       expect(page).to have_field(:dose3)
#       expect(page).to have_field(:as_needed)
#       expect(page).to have_field(:notes)
    
#     end
#   end
end