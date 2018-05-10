# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:subscriber).class_name('User') }
    it { is_expected.to belong_to(:subscribable) }
  end
end
