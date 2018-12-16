class User < ApplicationRecord
  has_many :articles
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def admin?
    admin
  end
end
