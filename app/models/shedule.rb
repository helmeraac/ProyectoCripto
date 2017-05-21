class Shedule < ApplicationRecord
  belongs_to :lab
  validates_presence_of :lab
  has_many :time_ranges, dependent: :delete_all


end
