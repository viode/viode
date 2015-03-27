class Category < ActiveRecord::Base
  has_many :questions, dependent: :destroy

  validates :name, presence: true

  scope :popular, -> { joins(:questions).group('categories.id').order('COUNT(questions.id) DESC') }
end
