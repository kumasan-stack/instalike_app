class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites,     dependent: :destroy
  has_many :comments,      dependent: :destroy
  has_many :notifications, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 50 }
  validates :image,   presence: true,
                      content_type: { in: %w[image/jpeg image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 2.megabytes,
                                      message: "should be less than 2MB" }

  # 表示用の正方形リサイズ済み画像を返す
  def display_square_image(side_length: 500)
    size = "#{side_length}x#{side_length}"
    image.variant(combine_options:{resize:"#{size}^",crop:"#{size}+0+0",gravity: :center})
  end
end
