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
    it { should validate_presence_of(:user_id) }
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

  describe "has_reputation" do
    it "has reputation upvotes" do
      expect(question.reputation_for(:upvotes)).to eq(0)
    end

    it "has reputation downvotes" do
      expect(question.reputation_for(:downvotes)).to eq(0)
    end

    it "has reputation votes" do
      expect(question.reputation_for(:votes)).to eq(0)
    end

    it "changes reputation for upvotes" do
      question.add_evaluation :upvotes, 1, user
      expect(question.reputation_for(:upvotes)).to eq(1)
    end

    it "changes reputation for downvotes" do
      question.add_evaluation :downvotes, -1, user
      expect(question.reputation_for(:downvotes)).to eq(-1)
    end

    it "changes reputation for votes" do
      question.add_evaluation :upvotes, 5, user
      question.add_evaluation :downvotes, -2, user
      expect(question.reputation_for(:votes)).to eq(3)
    end
  end
end
