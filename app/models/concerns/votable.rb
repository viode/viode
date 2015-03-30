module Votable
  extend ActiveSupport::Concern

  UPVOTE_VALUE = 1
  DOWNVOTE_VALUE = -1

  included do
    has_reputation :votes, source: :user
  end

  def votes
    reputation_for(:votes).to_i
  end

  def upvote_by(user)
    add_or_update_evaluation(:votes, UPVOTE_VALUE, user)
  end

  def upvoted_by?(user)
    evaluation_by(:votes, user) == UPVOTE_VALUE
  end

  def downvote_by(user)
    add_or_update_evaluation(:votes, DOWNVOTE_VALUE, user)
  end

  def downvoted_by?(user)
    evaluation_by(:votes, user) == DOWNVOTE_VALUE
  end
end
