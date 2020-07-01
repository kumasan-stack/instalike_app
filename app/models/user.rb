class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable,:omniauthable
  before_save { email.downcase! }
  validates :name,       presence: true, length: { maximum: 50 }
  validates :user_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,      presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password,   presence: true, length: { in: 6..50 },
            allow_nil: true
  validates :site_url,                   length: { maximum: 255 }
  validates :profile,                    length: { maximum: 300 }
  validates :phone_number,               length: { maximum: 13 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def self.from_omniauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid:       auth.uid,
        provider:  auth.provider,
        email:     auth.info.email,
        name:      auth.info.name,
        user_name: auth.info.name,
        password:  Devise.friendly_token[0, 20]
      )
    end
    user
  end
end