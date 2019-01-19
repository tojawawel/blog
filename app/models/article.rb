class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum:5}

  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: 'User'

  has_many :articles, foreign_key: :author_id
  has_many :likes
  has_many :liked_articles, through: :likes, source: :article

  def tags=(tags)
    tags = sanitize_tags(tags) if tags.is_a?(String)
    super(tags)
  end

  private
  def sanitize_tags(text)
    text.downcase.split.uniq
  end
end
