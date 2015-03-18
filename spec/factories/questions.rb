FactoryGirl.define do
  factory :question do
    user
    title { Faker::Lorem.sentence.tr('.', '?') }
    body { Faker::Lorem.paragraph(2) }
  end
end
