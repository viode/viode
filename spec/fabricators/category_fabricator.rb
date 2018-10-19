# frozen_string_literal: true

Fabricator(:category) do
  name        { Faker::Commerce.department(2) }
  description { Faker::Lorem.paragraph(2) }
end
