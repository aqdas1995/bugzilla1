class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bug_users, dependent: :destroy
  has_many :bugs, through: :bug_users
  has_many :projects, through: :bug_users
  has_many :projects, dependent: :destroy
end
