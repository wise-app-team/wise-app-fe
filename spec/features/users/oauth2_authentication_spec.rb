require 'rails_helper'

RSpec.feature "Google OAuth2 Authentication", type: :request do
  before do
    WebMock.allow_net_connect!

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = 
    OmniAuth::AuthHash.new({
      :provider=>"google_oauth2",
      :uid=>554012304,
      :info=>
      {:name=>"Lucie Collier", :first_name=>"Lucie", :last_name=>"Collier", :email=>"lucie_collier@hilpert.example", :image=>"https://via.placeholder.com/300x300.png"},
      :credentials=>
      {:token=>"e0df0b9acc20e62834539663e7ae165f", :refresh_token=>"02d8fe40c69ac023fbb9fc4742b8917c", :expires_at=>1687863960, :expires=>true}})
      
    @user_info = OmniAuth.config.mock_auth[:google_oauth2]
  end
  
  xit "logs in a user with valid credentials" do
    visit '/auth/google_oauth2'
    expect(page).to have_content 'Logged in successfully.'
    expect(page).to have_content 'Lucie Collier'
  end
  
  describe "callback" do
    
    it "authenticate a user" do
      get "/auth/google_oauth2/callback", params: { provider: @user_info.provider, uid: @user_info.uid }
      
      user = BackendFacade.new.find_by_email(@user_info.info.email)
# binding.pry
      expect(session["session_id"]).to_not be_nil
      expect(user).to_not be_nil
      expect(user.email).to eq(@user_info.info.email)
      expect(user.name).to eq(@user_info.info.name)
      expect(user.token).to eq(@user_info.credentials.token)
      expect(user.provider).to eq(@user_info.provider)
      
      WebMock.disable_net_connect!
    end
  end
    
    # xit "authenticate a user" do
    #   # auth_hash = OmniAuth.config.mock_auth[:google_oauth2]
    #   get "/auth/google_oauth2/callback", params: {provider: @user_info.provider, uid: @user_info.uid}
    #   # binding.pry
    # 
    #   BackendService.find_by_email(@user_info.info.email)
    # 
    #   user = User.find_by(google_id: 554012304)
    #   # expect(response).to redirect_to("/dashboard")
    #   expect(session["session_id"]).to_not be_nil
    #   expect(user).to_not be_nil
    #   expect(user.email).to eq(@user_info.info.email)
    #   expect(user.name).to eq(@user_info.info.name)
    #   expect(user.token).to eq(@user_info.credentials.token)
    #   expect(user.provider).to eq(@user_info.provider)
    #   # binding.pry
    # 
    # 
    #   #currently returning no users in the User.all array
    #   # binding.pry
    # 
    # 
    #   WebMock.disable_net_connect!
    # end
  # end
end