# frozen_string_literal: true

FactoryGirl.define do
  factory :user, aliases: %i[author subscriber] do
    fullname { Faker::Name.name }
    bio      { Faker::Name.title }
    email    { Faker::Internet.safe_email }
    username { Faker::Internet.user_name(3..20).tr('.-', '_') }
    password 'mysecret'
    avatar   { File.open('spec/fixtures/250.gif') }
    role 0

    factory :confirmed_user do
      confirmed_at { Time.current }
    end
  end
end
