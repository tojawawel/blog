class Comment < ApplicationRecord
  # include ActiveModel::Validations
  # attr_accessor :email
  #
  # validates :commenter, presence: true, email: true
  validates :body, presence: true, length: {in: 6..500}
  belongs_to :article, counter_cache: true
  belongs_to :user

end
