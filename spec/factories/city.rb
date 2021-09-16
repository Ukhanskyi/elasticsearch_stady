# frozen_string_literal: true

# Class for City
FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
  end
end
