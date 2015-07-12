class Answer < ActiveRecord::Base
  include Votable

  belongs_to :author, class_name: 'User'
  belongs_to :question, counter_cache: true

  has_reputation :votes, source: :user,
    source_of: { reputation: :answer_points, of: :author }

  validates :body, :question_id, :author_id, presence: true
  validates :body, length: { minimum: 2 }
  validate  :question_not_closed, on: :create

  scope :recent, -> { order('created_at DESC') }

  def question_not_closed
    errors.add(:question_closed, "The question you were trying to answer is older than 30 days") if
      !question_id.blank? and question.closed
  end
end
