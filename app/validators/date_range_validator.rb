class DateRangeValidator < ActiveModel::Validator
  def validate(record)
    #  start_time should be before end_time
    if record.start_time >= record.end_time
      record.errors[:base] << "La hora inicial es mayor o igual a la hora final"
    end
    
    matched_time_ranges = TimeRange.find_by_schedule_and_weekday(record.shedule,record.weekday)
    
    matched_time_ranges.each do |range|
      record_start_date_inside = record.start_time > range.start_time && record.start_time < range.end_time
      record_end_date_inside = record.end_time > range.start_time && record.end_time < range.end_time
      range_contained = range.start_time >= record.start_time && range.end_time <= record.end_time
      if record_start_date_inside || record_end_date_inside || range_contained
        record.errors[:base] << "El rango de horario se cruza con uno existente"
      end
    end
  end
end