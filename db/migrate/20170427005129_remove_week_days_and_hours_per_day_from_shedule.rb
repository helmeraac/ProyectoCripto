class RemoveWeekDaysAndHoursPerDayFromShedule < ActiveRecord::Migration[5.0]
  def change
    remove_column :shedules,:weekdays
    remove_column :shedules,:hours_per_day
  end
end
