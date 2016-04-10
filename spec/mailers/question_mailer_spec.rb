require "rails_helper"

RSpec.describe QuestionMailer, type: :mailer do
  let(:user)                { create :confirmed_user }
  let(:intended_respondent) { create :confirmed_user}
  let(:question)            { create :question, author: user, intended_respondent: intended_respondent.id }
  let(:mail)                { QuestionMailer.specified_user(question).deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq('Someone asked you a question')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([intended_respondent.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['from@example.com'])
  end

  it 'assigns @user' do
    expect(mail.body.encoded).to match(intended_respondent.username)
  end

  it 'assigns @question' do 
    expect(mail.body.encoded).to match(question.author.username)
  end

  it 'links to the question' do 
    #Matching against rails generated links causes the test to fail because the double quotes are escaped in the output
    expect(mail.body.encoded).to match(question.permalink)
  end
end
