class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_images, dependent: :destroy
  accepts_attachments_for :article_images, attachment: :image, append: true

  validates :user_id, presence: true
  validates :title  , presence: true
  validates :content, presence: true

  def liked_by(user, article)
    Like.where(user_id: user.id, article_id: article.id).exists?
  end
end
