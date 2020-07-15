class User < ApplicationRecord
  has_many :microposts,             dependent: :destroy
  has_many :favorites,              dependent: :destroy
  has_many :comments,               dependent: :destroy
  has_many :notifications,         class_name: "Notification",
                                  foreign_key: "passive_user_id",
                                    dependent: :destroy
  has_many :active_relationships,  class_name: "Relationship",
                                  foreign_key: "follower_id",
                                    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                    dependent: :destroy
  has_many :following,      through: :active_relationships,  source: :followed
  has_many :followers,      through: :passive_relationships, source: :follower
  has_many :favorite_posts, through: :favorites,             source: :micropost
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
  validates :profile,                    length: { maximum: 255 }
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

  def feed
    following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                      OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 投稿をお気に入りに入れる
  def add_favorite(micropost)
    favorite_posts << micropost
  end

  # 投稿のお気に入りを解除する
  def remove_favorite(micropost)
    favorites.find_by(micropost_id: micropost.id).destroy
  end

  # 現在のユーザーがお気に入り登録してたらtrueを返す
  def is_favorite?(micropost)
    favorite_posts.include?(micropost)
  end
end