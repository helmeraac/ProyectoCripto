class Category < ApplicationRecord
  has_many :categorizations
  has_many :posts, through: :categorizations

  validates :name, presence: true, length: {in: 3..150},uniqueness:true
  
  def to_s
    name
  end
end
