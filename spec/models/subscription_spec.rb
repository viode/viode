require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relations" do
    it { should belong_to(:subscriber).class_name('User') }
    it { should belong_to(:subscribable) }
  end
end
