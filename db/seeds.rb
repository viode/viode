include FactoryGirl::Syntax::Methods

create :confirmed_user, email: 'user@example.com'

5.times { create :confirmed_user }

User.all.each do |user|
  rand(2..5).times { create :question, user: user }
end
