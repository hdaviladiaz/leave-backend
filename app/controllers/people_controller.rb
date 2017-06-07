class PeopleController < ApplicationController
  def initialize()
    @peopleService = PeopleService.new()
  end

  def index
    render json: @peopleService.get_all
  end

  def show
    render json: @peopleService.get_by_id(params[:id])
  end
end
