class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum:5}
  has_many :comments, dependent: :destroy
end


#dependent pozwala na wypieprzenie calego artikla z podleglymi mu komentami
