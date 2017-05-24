class PostImage < ApplicationRecord
  belongs_to :post
  belongs_to :admin
  validates_presence_of :image
  mount_uploader :image , ImageUploader

  scope :without_post_for_admin, ->(admin) {where(:post => nil,:admin => admin)}
end
