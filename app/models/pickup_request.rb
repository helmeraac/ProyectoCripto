class PickupRequest < ApplicationRecord
  # Statuses
  PENDING = 0
  CONFIRMED = 1
  COMPLETED = 2

  # Limits
  MAX_PENDING_REQUESTS_PER_USER = 2

  belongs_to :user

  validates_presence_of :user
  validates :latitude, presence: true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90, only_integer: false}
  validates :longitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180, only_integer: false}
  validates :address, presence: true, length: {in: 10..250}
  validates :date, presence: true
  validates :status, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2}

  scope :for_user, ->(user_id) {where('user_id = ?', user_id)}
  scope :active_for_user, ->(user_id) {where('user_id = ? and status = ?', user_id, PENDING)}

  def status_string
    if status == 0
      'PENDIENTE'
    elsif status == 1
      'CONFIRMADA'
    elsif status == 2
      'COMPLETADO'
    end
  end

  def verify_status_change(new_status)
    if (status.zero? && new_status == 1) || (status == 1 && new_status == 2) || (status == 2 && new_status == 1)
      true
    else
      false
    end
  end
end
