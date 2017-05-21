class Post < ApplicationRecord
  belongs_to :admin
  has_many :taggings
  has_many :categorizations
  has_many :tags, through: :taggings
  has_many :categories, through: :categorizations

  validates_presence_of :admin
  validates :title, presence: true, length: {in: 3..150}
  validates :published_date, presence: true,date:{before: Proc.new { Time.now + 5.seconds }}
  validates :html_body, presence: true, length: {in: 4..5000}
  validates :header_img, presence: true, length: {in: 3..150}
end
