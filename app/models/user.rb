class User < ApplicationRecord

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  has_many :orders

  enum role: ['user', 'admin']
  has_secure_password(validations: false)

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  # validates :username, presence: true, uniqueness: true

  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  before_save :update_slug

  private

  def update_slug
    if username
      self.slug = username.gsub(" ", "-")
    end
  end

end
