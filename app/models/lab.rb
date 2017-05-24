class Lab < ApplicationRecord
  has_many :appointments, dependent: :delete_all
  has_many :admins, dependent: :delete_all
  has_many :results, dependent: :delete_all
  has_one :shedule, dependent: :destroy

  validates :city, presence: true, length: {in: 3..150}, uniqueness: true
  validates :address, presence: true, length: {in: 10..150}
  validates :phone, presence: true, length: {in: 7..10}

  def calculate_availability (datetime)
    available_hours = []
    weekday = datetime.wday
    time_ranges = TimeRange.find_by_schedule_and_weekday(self.shedule.id, weekday)

    time_ranges.each do |tr|
      current_time = tr.start_time
      while current_time < tr.end_time do
        available_hours.push(current_time.strftime("%I:%M %p"))
        current_time += Appointment::APPOINTMENT_DURATION.to_i.minutes
      end
    end

    existing_appointments = Appointment.find_requested_by_date(datetime)

    existing_appointments.each do |ea|
      hour = ea.date.strftime("%I:%M %p")
      if available_hours.include? hour
        available_hours.delete hour
      end
    end


    return available_hours
  end

  def to_s
    city
  end
end
