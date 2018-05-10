# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create :confirmed_user }

  describe 'relations' do
    it { is_expected.to have_many(:questions).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'popular scope' do
    it 'orders by questions count in descending order' do
      create :category
      c2 = create :category
      c3 = create :category

      create_list :question, 2, author: user, category: c2
      create_list :question, 3, author: user, category: c3

      expect(Category.popular).to eq([c3, c2])
    end
  end
end
