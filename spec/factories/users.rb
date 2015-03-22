FactoryGirl.define do
  factory :user do
    fullname { Faker::Name.name }
    bio      { Faker::Name.title }
    email    { Faker::Internet.safe_email }
    username { Faker::Internet.user_name }
    password '12345678'

    factory :confirmed_user do
      confirmed_at Time.now
    end
  end
end
