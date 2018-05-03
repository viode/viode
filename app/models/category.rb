class Category < ActiveRecord::Base
  acts_as_url :name, url_attribute: :permalink

  has_many :questions, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  validates :name, presence: true

  scope :popular, -> { joins(:questions).group('categories.id').order(Arel.sql('COUNT(questions.id) DESC')) }

  def to_param
    permalink
  end
end
