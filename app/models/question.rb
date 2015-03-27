class Question < ActiveRecord::Base
  include Votable

  acts_as_taggable

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category
  has_many :answers, dependent: :destroy

  validates :title, :category_id, :user_id, presence: true
  validates :title, length: { in: 10..140 }
  validate :amount_of_labels

  scope :recent, -> { order('created_at DESC') }

  def increment_views
    Question.where(id: id).update_all('views=views+1')
  end

  private

  def self.related_to(question)
    tagged_with(question.tag_list, any: true).where.not(id: question.id)
  end

  def amount_of_labels
    tags_count = tag_list.size
    errors.add(:labels, 'Please set labels (from 1 to 5)') if tags_count < 1 || tags_count > 5
  end
end
