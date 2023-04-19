# In spec/factories/users.rb

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    birthday { Faker::Date.between(from: 50.years.ago, to: 18.years.ago) }
    phone_number { Faker::PhoneNumber.phone_number }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
  end
end
