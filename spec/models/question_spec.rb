require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user)     { create :confirmed_user }
  let(:question) { create :question, author: user }

  describe "relations" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:category) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:author_id) }
    it { should validate_length_of(:title).is_at_least(10).is_at_most(140) }

    it "validates amount_of_labels" do
      question  = Question.create(tag_list: nil)
      question2 = Question.create(tag_list: '1,2,3,4,5,10')

      expect(question.errors[:labels].size).to eq(1)
      expect(question.errors[:labels]).to include('Please set labels (from 1 to 5)')
      expect(question2.errors[:labels].size).to eq(1)
      expect(question2.errors[:labels]).to include('Please set labels (from 1 to 5)')
    end
  end

  describe "recent scope" do
    it "orders by created_at date in descending order" do
      q1 = create :question, author: user, created_at: 1.day.ago
      q2 = create :question, author: user

      expect(Question.recent).to eq([q2, q1])
    end
  end

  describe "#increment_views" do
    it "increments question views" do
      views = question.views
      question.increment_views
      expect(question.reload.views).to eq(views+1)
    end
  end

  describe "#votes" do
    it "returns total votes" do
      question.add_evaluation :votes, 5, user

      expect(question.votes).to eql(5)
      expect(question.reputation_for(:votes)).to eql(5.0)
    end
  end

  describe "#upvote_by" do
    it "changes votes count positively" do
      expect { question.upvote_by(user) }.to change { question.votes }.from(0).to(1)
    end
  end

  describe "#upvoted_by?" do
    it "checks if question upvoted by user" do
      expect(question.upvoted_by?(user)).to be false

      question.add_evaluation :votes, Votable::UPVOTE_VALUE, user
      expect(question.upvoted_by?(user)).to be true
    end
  end

  describe "#downvote_by" do
    it "changes votes count negatively" do
      expect { question.downvote_by(user) }.to change { question.votes }.from(0).to(-1)
    end
  end

  describe "#downvoted_by?" do
    it "checks if question downvoted by user" do
      expect(question.downvoted_by?(user)).to be false

      question.add_evaluation :votes, Votable::DOWNVOTE_VALUE, user
      expect(question.downvoted_by?(user)).to be true
    end
  end
end
