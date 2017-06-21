class CalendarsController < ApplicationController
  def initialize()
    @calendar_service = CalendarsService.new()
  end

  def index
    render json: @calendar_service.get_all
  end
end
