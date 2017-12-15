class Bug < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :users, through: :bug_users

  validates :deadline, presence: true
  validates :type, presence: true
  validates :status, presence: true
end
