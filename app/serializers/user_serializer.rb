class UserSerializer
  include JSONAPI::Serializer
  attributes  :google_id,
              :name,
              :email,
              :password
              
  def self.format_users(auth_hash)
    binding.pry
    {
      user: 
      {
        name: auth_hash[:info][:name],
        email: auth_hash[:info][:email],
        password: auth_hash[:credentials][:token],
        password_confirmation: auth_hash[:credentials][:token]
      }
    }
  end
end

# user.provider = auth.provider
# user.google_id = auth.uid
# user.name = auth.info.name
# user.email = auth.info.email
# user.password = auth.credentials.token