class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings

  validates :name, presence: true, length: {in: 3..150},uniqueness:true
end
