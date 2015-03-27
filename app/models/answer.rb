class Answer < ActiveRecord::Base
  include Votable

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :question, counter_cache: true

  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 2 }
end
