FactoryGirl.define do
  factory :user, aliases: [:author] do
    fullname { Faker::Name.name }
    bio      { Faker::Name.title }
    email    { Faker::Internet.safe_email }
    username { Faker::Internet.user_name(3..20).tr('.-', '_') }
    password '12345678'
    avatar   { File.open('spec/fixtures/250.gif') }

    factory :confirmed_user do
      confirmed_at Time.now
    end
  end
end
