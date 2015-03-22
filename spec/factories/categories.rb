FactoryGirl.define do
  factory :category do
    name { Faker::Commerce.department(2) }
    description { Faker::Lorem.paragraph(2) }
  end
end
