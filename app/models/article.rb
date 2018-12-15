class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum:5}
  has_many :comments, dependent: :destroy
  belongs_to :user, dependent: :destroy

  def tags=(tags)
    tags = sanitize_tags(tags) if tags.is_a?(String)
    super(tags)
  end

  private
  def sanitize_tags(text)
    text.downcase.split.uniq
  end
end
