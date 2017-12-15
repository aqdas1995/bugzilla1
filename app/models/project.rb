class Project < ApplicationRecord
  belongs_to :user
  has_many :bugs
  has_many :users, through: :bugs
end
