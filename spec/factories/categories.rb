FactoryGirl.define do
  factory :category do
    name { "#{Faker::Lorem.word} category" }
    description { Faker::Lorem.paragraph(2) }
  end
end
