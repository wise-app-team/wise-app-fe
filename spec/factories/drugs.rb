# frozen_string_literal: true

FactoryBot.define do
  factory :drug do
    name { Faker::Cannabis.brand }
    synonym { Faker::Cannabis.strain }
  end
end
