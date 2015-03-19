include FactoryGirl::Syntax::Methods

create :confirmed_user, email: 'user@example.com', username: 'admin'

5.times do
  create :confirmed_user
  create :category
end

Category.all.each do |category|
  rand(2..5).times { create :question, user: User.all.sample, category: category }
end

Question.all.each do |question|
  rand(0..3).times { create :answer, user: User.all.sample, question: question }
end
