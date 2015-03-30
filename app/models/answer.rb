class Answer < ActiveRecord::Base
  include Votable

  belongs_to :author, class_name: 'User'
  belongs_to :question, counter_cache: true

  has_reputation :votes, source: :user,
    source_of: { reputation: :answer_points, of: :author }

  validates :body, :question_id, :author_id, presence: true
  validates :body, length: { minimum: 2 }

  scope :recent, -> { order('created_at DESC') }
end
