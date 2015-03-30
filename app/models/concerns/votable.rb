module Votable
  extend ActiveSupport::Concern

  included do
    has_reputation :votes, source: :user
  end

  def votes
    reputation_for(:votes).to_i
  end

  def upvote_by(user)
    add_or_update_evaluation(:votes, 1, user)
  end

  def downvote_by(user)
    add_or_update_evaluation(:votes, -1, user)
  end
end
