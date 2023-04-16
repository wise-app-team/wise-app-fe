class User
  attr_reader :first_name,
              :last_name,
              :email,
              :password,
              :password_confirmation,
              :birthday,
              :phone_number,
              :street_address,
              :city,
              :state,
              :zip_code

   def initialize(data)
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email = data[:email]
    @password = data[:password]
    @password_confirmation = data[:password_confirmation]
    @birthday = data[:birthday]
    @phone_number = data[:phone_number]
    @street_address = data[:address][:street_address]
    @city = data[:address][:city]
    @state = data[:address][:state]
    @zip_code = data[:address][:zip_code]
   end
 end