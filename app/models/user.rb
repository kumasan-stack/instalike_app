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
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider,
      user.uid =      auth.uid,
      user.name =     auth.info.name
      user.email =    auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end