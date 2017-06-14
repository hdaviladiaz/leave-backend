class PeopleController < ApplicationController
  def initialize()
    @people_service = PeopleService.new()
  end

  def index
    render json: @people_service.get_all
  end

  def show
    render json: @people_service.get_by_username(@user.username)
  end
end
