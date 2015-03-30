FactoryGirl.define do
  factory :question do
    author
    category
    title     { Faker::Lorem.sentence.tr('.', '?') }
    body      { Faker::Lorem.paragraph(2) }
    views     { rand(0..20) }
    tag_list  { Faker::Lorem.words.join(',') }
    permalink { Faker::Lorem.word }
    anonymous false

    factory :anonymous_question do
      anonymous true
    end
  end
end
