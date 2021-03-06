class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }, profanity_filter: true
  validates :address, presence: true, length: { maximum: 30 }, profanity_filter: true
  validate  :picture_size
  geocoded_by :address
  after_validation :geocode

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    like_users.include?(user)
  end

  def self.search(search)
    return Micropost.all unless search

    Micropost.where(['content LIKE ?', "%#{search}%"])
  end

  private

  def picture_size
    errors.add(:picture, '5MBを超える画像は投稿できません') if picture.size > 5.megabytes
  end
end
