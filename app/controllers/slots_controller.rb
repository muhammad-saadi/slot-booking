class SlotsController < ApplicationController
  def index
    @available_slots = Slot.available_slots(params[:date], params[:duration])

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    start_time = "#{params[:date]} #{params[:slot][:start].split('-').first}".to_datetime
    end_time = start_time + params[:duration].to_i.minutes
    @slot = Slot.new(start: start_time, end: end_time)
    if @slot.save
      redirect_to slots_path, :flash => { :success => "Your Slot has been booked successfully" }
    end
  end
end
