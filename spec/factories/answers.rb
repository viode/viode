FactoryGirl.define do
  factory :answer do
    user
    question
    body { Faker::Lorem.paragraph(5) }
  end
end
