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
    it { should validate_presence_of(:user_id) }
    it { should validate_length_of(:body).is_at_least(2) }
  end

  describe "has_reputation" do
    it "has reputation upvotes" do
      expect(answer.reputation_for(:upvotes)).to eq(0)
    end

    it "has reputation downvotes" do
      expect(answer.reputation_for(:downvotes)).to eq(0)
    end

    it "has reputation votes" do
      expect(answer.reputation_for(:votes)).to eq(0)
    end

    it "changes reputation for upvotes" do
      answer.add_evaluation :upvotes, 1, user
      expect(answer.reputation_for(:upvotes)).to eq(1)
    end

    it "changes reputation for downvotes" do
      answer.add_evaluation :downvotes, -1, user
      expect(answer.reputation_for(:downvotes)).to eq(-1)
    end

    it "changes reputation for votes" do
      answer.add_evaluation :upvotes, 5, user
      answer.add_evaluation :downvotes, -2, user
      expect(answer.reputation_for(:votes)).to eq(3)
    end
  end
end
