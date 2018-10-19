# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { Fabricate :confirmed_user }

  describe 'relations' do
    it { is_expected.to have_many(:questions).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'popular scope' do
    it 'orders by questions count in descending order' do
      Fabricate :category
      c2 = Fabricate :category
      c3 = Fabricate :category

      Fabricate.times(2, :question, author: user, category: c2)
      Fabricate.times(3, :question, author: user, category: c3)

      expect(Category.popular).to eq([c3, c2])
    end
  end
end
