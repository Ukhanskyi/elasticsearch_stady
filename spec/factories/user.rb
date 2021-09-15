# frozen_string_literal: true

# Class for User
FactoryBot.define do
  factory :user do
    first_name          { Faker::Name.first_name }
    last_name           { Faker::Name.last_name }
    email               { Faker::Internet.email }
    phone               { Faker::Number.leading_zero_number(digits: 10) }
    programing_language { Faker::ProgrammingLanguage.name }
    association :city, factory: :city
  end
end
