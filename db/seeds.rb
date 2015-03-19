include FactoryGirl::Syntax::Methods

create :confirmed_user, email: 'user@example.com'

5.times { create :confirmed_user }
8.times { create :category }

User.all.each do |user|
  rand(2..5).times { create :question, user: user }

  Question.all.each do |question|
    rand(2..5).times { create :answer, user: user, question: question }
  end
end
