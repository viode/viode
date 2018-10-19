# frozen_string_literal: true

Fabricator(:user, aliases: %i[author subscriber]) do
  fullname { Faker::Name.name }
  bio      { Faker::Job.title }
  email    { Faker::Internet.safe_email }
  username { Faker::Internet.user_name(3..20).tr('.-', '_') }
  password 'mysecret'
  avatar   { File.open('spec/fixtures/250.gif') }
  role 0
end

Fabricator(:confirmed_user, from: :user) do
  confirmed_at { Time.current }
end

Fabricator(:admin, from: :user) do
  email 'user@example.com'
  username 'admin'
  confirmed_at { Time.current }
  role 1
end
