class Appointment < ApplicationRecord

  # Statuses
  CONFIRMED = 0
  COMPLETED = 1
  CANCELED = -1
  # Limits
  MAX_APPOINTMENTS_PER_USER = 1
  APPOINTMENT_DURATION = 15

  belongs_to :lab
  belongs_to :user
  belongs_to :admin

  validates_presence_of :user
  validates_presence_of :lab
  # Validations
  validates :date, presence: true, date: {after: proc {Time.now - 5.seconds}}
  # Minutes
  validates :status, presence: true, numericality: {only_integer: true, greaØter_than_or_equal_to: 0, less_than_or_equal_to: 2}

  scope :find_by_user, ->(user_id) {where('user_id = ?', user_id)}
  scope :find_by_user_and_status, ->(user_id, status) {where('user_id = ? and status = ?', user_id, status)}
  scope :find_by_date, -> (datetime) {where('date BETWEEN ? and ?', datetime.beginning_of_day, datetime.end_of_day)}
  scope :find_by_lab, ->(lab_id) {where('lab_id = ?', lab_id)}
  scope :find_by_status, ->(status) {where('status = ?', status)}
  scope :find_to_reminder, ->(datetime) {where('status = ? and date BETWEEN ? and ?',Appointment::CONFIRMED,datetime.beginning_of_day, datetime.end_of_day)}
  scope :find_by_lab_and_status, ->(lab_id, status) {where('lab_id = ? and status =?', lab_id, status)}

  def status_string
    if status == 0
      'CONFIRMADA'
    elsif status == 1
      'COMPLETADA'
    elsif status == -1
      'CANCELADA'
    end
  end

  def verify_status_change(new_status,type_of_user)
    if (status.zero? && new_status == -1) || (status.zero? && new_status == 1 && type_of_user.zero?)
      true
    else
      false
    end
  end

end
