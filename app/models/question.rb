class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy

  validates :title, :category_id, presence: true
end
