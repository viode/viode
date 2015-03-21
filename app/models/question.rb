class Question < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy

  validates :title, :category_id, presence: true
  validate :amount_of_labels

  scope :recent, -> { order('created_at DESC') }

  private

  def amount_of_labels
    tags_count = tag_list.size
    errors.add(:labels, 'Please set labels (from 1 to 5)') if tags_count < 1 || tags_count > 5
  end
end
