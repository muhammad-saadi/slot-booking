class SlotsController < ApplicationController
  def index
    @slots = Slot.all
  end

  def create
  end
end
