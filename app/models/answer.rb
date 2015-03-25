class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  has_reputation :upvotes, source: :user
  has_reputation :downvotes, source: :user
  has_reputation :votes, source: [{ reputation: :upvotes }, { reputation: :downvotes }]

  validates :body, presence: true

  def votes
    reputation_for(:votes).to_i
  end
end
