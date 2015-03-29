class Category < ActiveRecord::Base
  acts_as_url :name, url_attribute: :permalink

  has_many :questions, dependent: :destroy

  validates :name, presence: true

  scope :popular, -> { joins(:questions).group('categories.id').order('COUNT(questions.id) DESC') }

  def to_param
    permalink
  end
end
