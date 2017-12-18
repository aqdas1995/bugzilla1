class Project < ApplicationRecord
  belongs_to :user
  has_many :bugs, dependent: :destroy
  has_many :users, through: :bugs
end
