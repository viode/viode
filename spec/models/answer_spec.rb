require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user)   { create :confirmed_user }
  let(:answer) { create :answer, author: user }

  describe "relations" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:question) }
  end

  describe "validations" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:question_id) }
    it { should validate_presence_of(:author_id) }
    it { should validate_length_of(:body).is_at_least(2) }
  end

  describe "#votes" do
    it "returns total votes" do
      answer.add_evaluation :votes, 5, user

      expect(answer.votes).to eql(5)
      expect(answer.reputation_for(:votes)).to eql(5.0)
    end
  end

  describe "#upvote_by" do
    it "changes votes count positively" do
      expect { answer.upvote_by(user) }.to change { answer.votes }.from(0).to(1)
    end
  end

  describe "#downvote_by" do
    it "changes votes count negatively" do
      expect { answer.downvote_by(user) }.to change { answer.votes }.from(0).to(-1)
    end
  end
end
