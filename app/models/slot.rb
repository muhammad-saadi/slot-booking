class Slot < ApplicationRecord
  def self.available_slots(selected_date, duration)
    if selected_date.present? && duration.present?
      selected_date = selected_date.to_datetime
      duration = duration.to_i
      booked_slots = Slot.where(start: selected_date..selected_date.end_of_day).order('start Asc').pluck(:start, :end)
      available_slots = []
      start_time = selected_date

      booked_slots.each do |slot|
        duration_between_slots = ((slot[0] - start_time)/1.minutes).to_i
        available_slots = empty_slots(available_slots, start_time, slot[0], duration_between_slots, duration)
        tart_time = slot[1]
      end

      duration_between_slots = (((selected_date.end_of_day - start_time.to_datetime)*24*60).to_i)
      available_slots = empty_slots(available_slots, start_time, selected_date.end_of_day, duration_between_slots, duration)
    end

    available_slots
  end

  def self.empty_slots(available_slots, start_time, end_time, duration_between_slots, duration)
    if duration_between_slots >= duration
      counter = 0

      while(start_time + (15*counter).minutes < end_time)
        available_slots.push("#{(start_time + (15*counter).minutes).strftime("%H:%M")} - #{(start_time + (15*counter +duration).minutes).strftime("%H:%M")}")
        counter+=1
      end
    end
    available_slots
  end
end
