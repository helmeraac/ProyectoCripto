class TimeRange < ApplicationRecord
  belongs_to :shedule
  validates_presence_of :shedule
  validates_with DateRangeValidator

  scope :find_by_shedule, ->(shedule_id) { where('shedule_id = ?', shedule_id) }
  scope :find_by_schedule_and_weekday, ->(shedule_id,weekday) { where('shedule_id = ? and weekday= ?', shedule_id,weekday) }


  def self.create_time_range(time_range_params)
    weekday = time_range_params[:weekday]
    start_time = time_range_params[:start_time]
    end_time = time_range_params[:end_time]
    shedule_id = time_range_params[:shedule_id]

    if !start_time.nil? && !end_time.nil?
      start_time = "1970-01-01 " + start_time.to_s + " -0500"
      end_time = "1970-01-01 " + end_time.to_s + " -0500"
    end
    time_range = TimeRange.new(shedule_id: shedule_id, weekday:weekday, start_time: DateTime.parse(start_time), end_time: DateTime.parse(end_time))
    time_range
  end
end
