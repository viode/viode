include FactoryGirl::Syntax::Methods

create :confirmed_user, email: 'user@example.com'

5.times do
  create :confirmed_user
  create :category
end

User.all.each do |user|
  Category.all.each do |category|
    rand(2..5).times { create :question, user: user, category: category }
  end

  Question.all.each do |question|
    rand(2..5).times { create :answer, user: user, question: question }
  end
end
