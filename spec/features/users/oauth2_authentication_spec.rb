require 'rails_helper'

RSpec.feature "Google OAuth2 Authentication", type: :request do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '12345',
      info: {
        email: 'lochnessie@gmail.com',
        name: 'Vanessa Loch'
        },
      credentials: {
        token: '234978018904890'
      }
      })
    
    # stub_request(:post, "http://localhost:5000/api/v1/users").
    #     with(
    #       body: {"user"=>{"email"=>"lochnessie@gmail.com", "name"=>"Vanessa Loch", "provider"=>"google_oauth2", "token"=>"234978018904890"}},
    #       headers: {
    #          'Accept'=>'*/*',
    #          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #          'Content-Type'=>'application/x-www-form-urlencoded',
    #          'User-Agent'=>'Faraday v2.7.4'
    #       }).
    #     to_return(status: 200, body: "", headers: {})
  end
  
  describe "callback" do
    it "authenticate a user" do
      WebMock.allow_net_connect!
      get "/auth/google_oauth2/callback"
      
      # binding.pry
      expect(response).to redirect_to("/dashboard")
      expect(session[:user_id]).to_not be_nil
      
      WebMock.disable_net_connect!
    end
  end
  
  after do
    
  end
end