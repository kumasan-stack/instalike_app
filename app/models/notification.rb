class Notification < ApplicationRecord
  belongs_to :micropost
  belongs_to :passive_user,    class_name: "User"
  belongs_to :active_user,     class_name: "User"
  validates  :micropost_id,    presence: true
  validates  :passive_user_id, presence: true
  validates  :active_user_id,  presence: true
  validates  :activity,        presence: true
  default_scope -> { order(created_at: :desc) }
end
