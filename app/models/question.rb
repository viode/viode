class Question < ActiveRecord::Base
  acts_as_taggable

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category
  has_many :answers, dependent: :destroy

  has_reputation :upvotes, source: :user
  has_reputation :downvotes, source: :user
  has_reputation :votes, source: [{ reputation: :upvotes }, { reputation: :downvotes }]

  validates :title, :category_id, presence: true
  validate :amount_of_labels

  scope :recent, -> { order('created_at DESC') }

  def votes
    reputation_for(:votes).to_i
  end

  private

  def amount_of_labels
    tags_count = tag_list.size
    errors.add(:labels, 'Please set labels (from 1 to 5)') if tags_count < 1 || tags_count > 5
  end
end
