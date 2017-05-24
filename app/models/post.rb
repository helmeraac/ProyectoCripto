class Post < ApplicationRecord
  PER_PAGE = 3
  belongs_to :admin
  has_many :taggings
  has_many :categorizations
  has_many :tags, through: :taggings
  has_many :categories, through: :categorizations
  has_many :post_images, dependent: :destroy

  validates_presence_of :admin
  validates :title, presence: true, length: {in: 3..350}
  validates :html_body, presence: true, allow_blank: false
  validates :html_summary, presence: true, allow_blank: false
  mount_uploader :header_img , ImageUploader

  scope :for_admin, ->(admin) {where(:admin => admin)}
  scope :by_category, ->(category) {joins(:categories).where("categories.id = (?)",category.id)}
  scope :by_tag, ->(tag) {joins(:tags).where("tags.id = (?)",tag.id)}

end
