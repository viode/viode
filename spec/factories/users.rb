FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password '12345678'

    factory :confirmed_user do
      confirmed_at Time.now
    end
  end
end
