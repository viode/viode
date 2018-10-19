# frozen_string_literal: true

AvatarUploader.enable_processing = false

unless User.exists?(username: 'admin')
  admin = Fabricate :admin
  warn "\nCreated a user with credentials: #{admin.username}/#{admin.password}"
end

Fabricate.times(5, :confirmed_user)
Fabricate.times(36, :category)

Category.first(3).each do |category|
  Fabricate.times(rand(2..5), :question,
                  author: User.all.sample, category: category, created_at: Faker::Date.backward(20))
end

Question.all.each do |question|
  Fabricate.times(rand(0..5), :answer, author: User.all.sample, question: question)
end
