# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)     { Fabricate :confirmed_user }
  let(:category) { Fabricate :category }
  let(:question) { Fabricate :question, author: user }

  describe 'relations' do
    it {
      is_expected.to have_many(:answers).conditions(anonymous: false)
        .with_foreign_key('author_id').dependent(:destroy)
    }
    it {
      is_expected.to have_many(:questions).conditions(anonymous: false)
        .with_foreign_key('author_id').dependent(:destroy)
    }
    it { is_expected.to have_many(:subscriptions).with_foreign_key('subscriber_id').dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it {
      is_expected.not_to allow_value('stop!', 'with-slash')
        .for(:username).with_message('can contain only letters, numbers and underscore')
    }
    it { is_expected.to validate_length_of(:username).is_at_least(3).is_at_most(20) }
    it { is_expected.to validate_length_of(:fullname).is_at_least(2).is_at_most(90) }
    it { is_expected.to allow_value('', nil).for(:fullname) }
    it { is_expected.to validate_length_of(:bio).is_at_most(400) }
  end

  describe '#subscribe_to' do
    it 'subscribes user to subscribable' do
      subscribable = category
      expect { user.subscribe_to(subscribable) }.to change(user.subscriptions, :count).by(1)

      subscription = user.subscriptions.last
      expect(subscription.subscribable_id).to eq(subscribable.id)
      expect(subscription.subscribable_type).to eq(subscribable.class.to_s)
      expect(subscription.subscriber_id).to eq(user.id)
    end
  end

  describe '#unsubscribe_from' do
    it 'unsubscribes user from subscribable' do
      subscribable = category
      Fabricate :subscription, subscribable: subscribable, subscriber: user

      expect { user.unsubscribe_from(subscribable) }.to change(user.subscriptions, :count).by(-1)
    end
  end

  describe '#subscribed_to?' do
    it 'checks if user subscribed to subscribable' do
      Fabricate :subscription, subscribable: category, subscriber: user
      category2 = Fabricate :category

      expect(user.subscribed_to?(category)).to be true
      expect(user.subscribed_to?(category2)).to be false
    end
  end

  describe 'star_points reputation' do
    it "changes when author's question is starred" do
      expect do
        question.add_evaluation :stars, 1, user
      end.to change { user.reputation_for(:star_points) }.from(0).to(2)
    end
  end

  describe '.add_initial_points' do
    it 'adds initial user points' do
      new_user = Fabricate :confirmed_user

      expect(new_user.reputation_for(:bonus_points)).to eq(100)
      expect(new_user.reputation_for(:points)).to eq(100)
    end
  end
end
