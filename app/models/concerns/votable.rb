module Votable
  extend ActiveSupport::Concern

  included do
    has_reputation :upvotes, source: :user
    has_reputation :downvotes, source: :user
    has_reputation :votes, source: [{ reputation: :upvotes }, { reputation: :downvotes }]
  end

  def votes
    reputation_for(:votes).to_i
  end

  def upvote_by(user)
    if has_evaluation?(:upvotes, user)
      delete_evaluation(:upvotes, user)
    else
      delete_evaluation(:downvotes, user)
      add_evaluation(:upvotes, 1, user)
    end
  end

  def downvote_by(user)
    if has_evaluation?(:downvotes, user)
      delete_evaluation(:downvotes, user)
    else
      delete_evaluation(:upvotes, user)
      add_evaluation(:downvotes, -1, user)
    end
  end
end
