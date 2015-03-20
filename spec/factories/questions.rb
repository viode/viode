FactoryGirl.define do
  factory :question do
    user
    category
    title { Faker::Lorem.sentence.tr('.', '?') }
    body { Faker::Lorem.paragraph(2) }
    views { rand(0..20) }
  end
end
