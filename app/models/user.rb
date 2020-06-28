class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name,       presence: true, length: { maximum: 50 }
  validates :user_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,      presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password,   presence: true, length: { minimum: 8, maximum: 50 }
  validates :site_url,                   length: { maximum: 255 }
  validates :profile,                    length: { maximum: 300 }
  validates :phone_number,               length: { maximum: 14 }

  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # 永続セッションのためにユーザーをデータベースに登録する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end