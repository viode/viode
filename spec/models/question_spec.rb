require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create :confirmed_user }

  describe "relations" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:category) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:category_id) }

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
end
