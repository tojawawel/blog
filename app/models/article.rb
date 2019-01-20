class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum:5}

  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :articles, foreign_key: :author_id
  has_many :likes
  has_many :liked_articles, through: :likes, source: :article

  scope :published, -> {where(published: true)}
  scope :most_commented, -> {order(comments_count: :desc).first}

  def tags=(tags)
    tags = sanitize_tags(tags) if tags.is_a?(String)
    super(tags)
  end

  def css_class
    if published?
      'normal'
    else
      'unpublished'
    end
  end

  private
  def sanitize_tags(text)
    text.downcase.split.uniq
  end
end
