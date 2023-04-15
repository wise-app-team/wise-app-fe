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

   def save
    response = BackendService.new.save_user(to_params)
    # binding.pry
    if response.status == 201
      true
    else
      false
    end
  end

  def to_params
    {
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      birthday: birthday,
      phone_number: phone_number,
      street_address: street_address,
      city: city,
      state: state,
      zip_code: zip_code
    }
  end
 end