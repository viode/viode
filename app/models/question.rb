class Question < ActiveRecord::Base
  include Votable

  searchkick
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

  scope :recent, -> { order('created_at DESC') }

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

  private

  def self.related_to(question)
    tagged_with(question.tag_list, any: true).where.not(id: question.id)
  end

  def amount_of_labels
    tags_count = tag_list.size
    errors.add(:labels, 'Please set labels (from 1 to 5)') if tags_count < 1 || tags_count > 5
  end
end
