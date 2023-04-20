require 'rails_helper'

RSpec.describe UserPoro do
  it "exists" do
    attrs = {:id=>"1",
		:type=>"user",
		:attributes=>
		{
      name: "Pedro Pascal",
      email: "pedro@pedro.com",
      birthday: "04/05/1975",
      phone_number: "555-555-5555",
      street_address: "123 Main St",
      city: "Denver",
      state:  "CO",
      zip_code: "80209",
      token: "12345",
      provider: "google"
		}
	}

    user = UserPoro.new(attrs)

    expect(user).to be_a(UserPoro)
    expect(user.id).to eq("1")
    expect(user.name).to eq("Pedro Pascal")
    expect(user.email).to eq("pedro@pedro.com")
    expect(user.birthday).to eq("04/05/1975")
    expect(user.phone_number).to eq("555-555-5555")
    expect(user.street_address).to eq("123 Main St")
    expect(user.city).to eq("Denver")
    expect(user.state).to eq("CO")
    expect(user.zip_code).to eq("80209")
    expect(user.token).to eq("12345")
    expect(user.provider).to eq("google")
  end
end