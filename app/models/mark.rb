class Mark < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  validates :user, uniqueness: {scope: :comment, message: 'you already gave a mark'  }
end
