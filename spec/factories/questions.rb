FactoryGirl.define do
  factory :question do
    user
    category
    title    { Faker::Lorem.sentence.tr('.', '?') }
    body     { Faker::Lorem.paragraph(2) }
    views    { rand(0..20) }
    tag_list { Faker::Lorem.words.join(',') }
  end
end
