# frozen_string_literal: true

class Category < ApplicationRecord
  acts_as_url :name, url_attribute: :permalink

  has_many :questions, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  validates :name, presence: true

  def self.popular
    joins(:questions)
      .group('categories.id')
      .order(Arel.sql('COUNT(questions.id) DESC'))
  end

  def to_param
    permalink
  end
end
