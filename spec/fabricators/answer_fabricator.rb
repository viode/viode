# frozen_string_literal: true

Fabricator(:answer) do
  author
  question
  body { Faker::Lorem.paragraph(5) }
  anonymous false
end

Fabricator(:anonymous_answer, from: :answer) do
  anonymous true
end
