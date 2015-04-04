require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)     { create :confirmed_user }
  let(:category) { create :category }

  describe "relations" do
    it { should have_many(:answers).conditions(anonymous: false).
      with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:questions).conditions(anonymous: false).
      with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:subscriptions).with_foreign_key('subscriber_id').dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should_not allow_value('stop!', 'with-slash').
      for(:username).with_message('can contain only letters, numbers and underscore') }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }
    it { should validate_length_of(:fullname).is_at_least(2).is_at_most(90) }
    it { should allow_value('', nil).for(:fullname) }
    it { should validate_length_of(:bio).is_at_most(400) }
  end

  describe "#subscribe_to" do
    it "subscribes user to subscribable" do
      subscribable = category
      expect { user.subscribe_to(subscribable) }.to change(user.subscriptions, :count).by(1)

      subscription = user.subscriptions.last
      expect(subscription.subscribable_id).to eq(subscribable.id)
      expect(subscription.subscribable_type).to eq(subscribable.class.to_s)
      expect(subscription.subscriber_id).to eq(user.id)
    end
  end

  describe "#unsubscribe_from" do
    it "unsubscribes user from subscribable" do
      subscribable = category
      create :subscription, subscribable: subscribable, subscriber: user

      expect { user.unsubscribe_from(subscribable) }.to change(user.subscriptions, :count).by(-1)
    end
  end

  describe "#subscribed_to?" do
    it "checks if user subscribed to subscribable" do
      create :subscription, subscribable: category, subscriber: user
      category2 = create :category

      expect(user.subscribed_to?(category)).to be true
      expect(user.subscribed_to?(category2)).to be false
    end
  end
end
