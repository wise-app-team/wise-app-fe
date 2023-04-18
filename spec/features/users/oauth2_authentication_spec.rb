require 'rails_helper'

RSpec.feature "Google OAuth2 Authentication", type: :request do
  before do
    # WebMock.allow_net_connect!
    
    
    # binding.pry
    # click_on ""
    # OmniAuth.config.test_mode = true
    # @user_info = OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    #   provider: 'google_oauth2',
    #   uid: '12345',
    #   info: {
    #     email: 'lochnessie@gmail.com',
    #     name: 'Vanessa Loch'
    #     },
    #   credentials: {
    #     token: '234978018904890'
    #   }
    #   })
    
  end
  
  describe "callback" do
    it "authenticate a user" do
      
      WebMock.allow_net_connect!
      # visit "/"
      # save_and_open_page
      
      get "/auth/google_oauth2/callback"
      post "/auth/google_oauth2/callback"
      
      # binding.pry
      # expect(response).to redirect_to("/dashboard")
      expect(session["session_id"]).to_not be_nil
      binding.pry
      
      user = User.find_by(email: 'lochnessie@gmail.com')
      #currently returning no users in the User.all array
      binding.pry
      
      
      WebMock.disable_net_connect!
    end
  end
end