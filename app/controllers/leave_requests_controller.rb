class LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [:show, :update, :destroy]
  before_action :verify_admin!, only: [:index]

  # GET /leave_requests only for admins
  def index
    @leave_requests = LeaveRequest.all
    render json: @leave_requests
  end

  # GET /leave_requests/me
  def me
    @leave_requests = LeaveRequest.where(employee_id: @user.email)
    render json: @leave_requests
  end

  # GET /leave_requests/me/approve
  def approve
    @leave_requests = LeaveRequest.where(approver_id: @user.email)
    render json: @leave_requests
  end

  # GET /leave_requests/1
  def show
    render json: @leave_request
  end

  # POST /leave_requests
  def create
    @leave_request = LeaveRequest.new(leave_request_params)

    if @leave_request.save
      render json: @leave_request, status: :created, location: @leave_request
    else
      render json: @leave_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leave_requests/1
  def update
    if @leave_request.update(leave_request_params)
      render json: @leave_request
    else
      render json: @leave_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leave_requests/1
  def destroy
    @leave_request.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_leave_request
    @leave_request = LeaveRequest.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def leave_request_params
    params.require(:leave_request).permit(:employee_id, :start_date, :end_date, :return_date)
  end
end
