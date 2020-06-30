class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :rememberable, :validatable,:omniauthable
  before_save { email.downcase! }
  validates :name,       presence: true, length: { maximum: 50 }
  validates :user_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,      presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password,   presence: true, length: { minimum: 8, maximum: 50 },
            allow_nil: true
  validates :site_url,                   length: { maximum: 255 }
  validates :profile,                    length: { maximum: 300 }
  validates :phone_number,               length: { maximum: 14 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end