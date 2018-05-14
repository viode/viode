# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  enum role: %i[user admin moderator banned]

  has_many :answers, -> { where(anonymous: false) }, foreign_key: :author_id, dependent: :destroy
  has_many :questions, -> { where(anonymous: false) }, foreign_key: :author_id, dependent: :destroy
  has_many :subscriptions, foreign_key: :subscriber_id, dependent: :destroy

  has_reputation :answer_points, source: { reputation: :votes, of: :answers, weight: ViodeSettings.points.answer }
  has_reputation :question_points, source: { reputation: :votes, of: :questions, weight: ViodeSettings.points.question }
  has_reputation :star_points, source: { reputation: :stars, of: :questions, weight: ViodeSettings.points.star }
  has_reputation :bonus_points, source: :user
  has_reputation :points, source: [
    { reputation: :answer_points },
    { reputation: :question_points },
    { reputation: :star_points },
    { reputation: :bonus_points }
  ]

  validates :bio, length: { maximum: 400 }
  validates :fullname, length: { in: 2..90 }, allow_blank: true
  validates :username, length: { in: 3..20 },
                       format: { with: /\A\w+\z/, message: 'can contain only letters, numbers and underscore' }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  after_create :add_initial_points

  def to_param
    username
  end

  def subscribe_to(subscribable)
    subscriptions.create(subscribable: subscribable) unless subscribed_to?(subscribable)
  end

  def unsubscribe_from(subscribable)
    return unless subscribed_to?(subscribable)
    subscriptions.where(
      subscribable_id: subscribable.id,
      subscribable_type: subscribable.class.name
    ).destroy_all
  end

  def subscribed_to?(subscribable)
    subscriptions.where(
      subscribable_id: subscribable.id,
      subscribable_type: subscribable.class.name
    ).any?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  private

  def add_initial_points
    increase_evaluation(:bonus_points, ViodeSettings.points.initial, self)
  end
end
