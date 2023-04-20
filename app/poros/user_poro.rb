class UserPoro
  attr_reader :name,
              :email,
              :birthday,
              :phone_number,
              :street_address,
              :city,
              :state,
              :zip_code,
              :token,
              :provider,
              :id

  def initialize(data)
    # binding.pry
    @id = data[:id]
    @name = data[:attributes][:name]
    @email = data[:attributes][:email]
    @birthday = data[:attributes][:birthday]
    @phone_number = data[:attributes][:phone_number]
    @street_address = data[:attributes][:street_address]
    @city = data[:attributes][:city]
    @state = data[:attributes][:state]
    @zip_code = data[:attributes][:zip_code]
    @token = data[:attributes][:token]
    @provider = data[:attributes][:provider]
  end
end