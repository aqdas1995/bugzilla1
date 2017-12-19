class Bug < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :bug_users, dependent: :destroy
  has_many :users, through: :bug_users

  validates :deadline, presence: true
  validates :bug_type, presence: true
  validates :status, presence: true

  mount_uploader :image, ScreenshotUploader
end
