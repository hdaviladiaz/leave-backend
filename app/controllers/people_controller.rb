class PeopleController < ApplicationController
  def initialize()
    @people_service = PeopleService.new()
  end

  def index
    render json: @people_service.get_all
  end

  def index_except_me
    render json: @people_service.get_all_except_me(@user.username)
  end

  def show
    render json: @people_service.get_by_username(@user.username)
  end
end
