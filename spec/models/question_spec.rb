require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create :confirmed_user }

  describe "relations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:category_id) }
  end

  describe "recent scope" do
    it "orders by created_at date in descending order" do
      q1 = create :question, user: user, created_at: 1.day.ago
      q2 = create :question, user: user

      expect(Question.recent).to eq([q2, q1])
    end
  end
end
