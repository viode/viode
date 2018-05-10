# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :subscribable, polymorphic: true
  belongs_to :subscriber, class_name: 'User'
end
