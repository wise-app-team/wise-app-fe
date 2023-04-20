# class User < ApplicationRecord
#   attr_accessor :provider
  
#   def self.from_omniauth(auth)
#     where(provider: auth.provider, google_id: auth.uid).first_or_create do |user|
#       user.provider = auth.provider
#       user.google_id = auth.uid
#       user.name = auth.info.name
#       user.email = auth.info.email
#       user.token = auth.credentials.token
#     end
#   end
# end
