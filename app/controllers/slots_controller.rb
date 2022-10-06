class SlotsController < ApplicationController
  def index
    @available_slots = Slot.available_slots(params[:date], params[:duration])

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @slot = Slot.new(slot_params)
    if @slot.save
      redirect_to slots_path, :flash => { :success => "Your Slot has been booked successfully" }
    else
      render 'index'
    end
  end

  private

  def slot_params
    start_time = params[:slot][:start].present? ? "#{params[:date]} #{params[:slot][:start].split('-').first}".to_datetime : nil
    {
      start: start_time,
      end: start_time.present? ? start_time + params[:duration].to_i.minutes : nil
    }
  end
end
