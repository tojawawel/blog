class User < ApplicationRecord
  has_many :articles
  has_many :comments
  has_many :marks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def admin?
    admin
  end
end
