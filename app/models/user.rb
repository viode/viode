class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :answers, foreign_key: :author_id, dependent: :destroy
  has_many :questions, foreign_key: :author_id, dependent: :destroy

  has_reputation :answer_points, source: { reputation: :votes, of: :answers }
  has_reputation :question_points, source: { reputation: :votes, of: :questions }
  has_reputation :points, source: [{ reputation: :answer_points }, { reputation: :question_points }]

  validates :bio, length: { maximum: 400 }
  validates :fullname, length: { in: 2..90 }, allow_blank: true
  validates :username, length: { in: 3..20 },
            format: { with: /\A\w+\z/, message: 'can contain only letters, numbers and underscore' }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def to_param
    username
  end

  private

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end
end
