class Answer < ActiveRecord::Base
  include Votable

  belongs_to :author, class_name: 'User'
  belongs_to :question, counter_cache: true

  has_reputation :votes, source: :user,
    source_of: { reputation: :answer_points, of: :author }

  validates :body, :question_id, :author_id, presence: true
  validates :body, length: { minimum: 2 }
  validate  :question_not_expired

  scope :recent, -> { order('created_at DESC') }

  def question_not_expired
    errors.add(:question_expired, "The question you were trying to answer was odler than 30 days") if
      !question_id.blank? and question.created_at < Date.today - 30.days
  end
end
