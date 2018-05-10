# frozen_string_literal: true

class Question < ApplicationRecord
  include Votable

  acts_as_taggable
  acts_as_url :title, url_attribute: :permalink

  belongs_to :author, class_name: 'User'
  belongs_to :category
  has_many :answers, dependent: :destroy

  has_reputation :stars, source: :user,
                         source_of: { reputation: :star_points, of: :author }
  has_reputation :votes, source: :user,
                         source_of: { reputation: :question_points, of: :author }

  validates :title, :category_id, :author_id, presence: true
  validates :title, length: { in: 10..140 }
  validate :amount_of_labels

  scope :recent,        -> { order(created_at: :desc) }
  scope :to_be_closed,  -> { where(['created_at < ? AND closed = ?', 31.days.ago, false]) }

  def self.search(query)
    where('title ILIKE ?', "%#{query}%")
  end

  def to_param
    "#{id}/#{permalink}"
  end

  def increment_views
    Question.where(id: id).update_all('views=views+1')
  end

  def star_by(user)
    starred_by?(user) ? delete_evaluation(:stars, user) : add_evaluation(:stars, 1, user)
  end

  def starred_by?(user)
    evaluation_by(:stars, user) == 1
  end

  def self.related_to(question)
    tagged_with(question.tag_list, any: true).where.not(id: question.id)
  end

  private

  def amount_of_labels
    tags_count = tag_list.size
    errors.add(:labels, 'Please set labels (from 1 to 5)') if tags_count < 1 || tags_count > 5
  end
end
