class User < ApplicationRecord
  has_many :articles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def admin?
    admin
  end
end
