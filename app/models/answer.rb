class Answer < ActiveRecord::Base
  include Votable

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :question, counter_cache: true

  validates :body, presence: true
end
