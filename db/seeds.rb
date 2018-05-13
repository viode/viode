# frozen_string_literal: true

include FactoryGirl::Syntax::Methods

AvatarUploader.enable_processing = false

unless User.exists?(username: 'admin')
  admin = create :admin
  puts "\nCreated a user with credentials: #{admin.username}/#{admin.password}"
end

5.times { create :confirmed_user }
36.times { create :category }

Category.first(3).each do |category|
  rand(2..5).times { create :question, author: User.all.sample, category: category, created_at: Faker::Date.backward(20) }
end

Question.all.each do |question|
  rand(0..5).times { create :answer, author: User.all.sample, question: question }
end
