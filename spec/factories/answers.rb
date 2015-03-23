FactoryGirl.define do
  factory :answer do
    user
    question
    body { Faker::Lorem.paragraph(5) }
    anonymous false

    factory :anonymous_answer do
      anonymous true
    end
  end
end
