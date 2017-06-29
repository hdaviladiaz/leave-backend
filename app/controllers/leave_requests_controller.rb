class LeaveRequestsController < ApplicationController
  # skip_before_action :require_sign_in!
  before_action :set_leave_request, only: [:show, :update, :destroy, :approved, :rejected]
  before_action :verify_admin!, only: [:index]

  # GET /leave_requests only for admins
  def index
    @leave_requests = LeaveRequest.all
    render json: @leave_requests
  end

  # GET /leave_requests/me
  def me
    @leave_requests = LeaveRequest.where(employee_id: @user.email).order('start_date')
    render json: @leave_requests
  end

  # GET /leave_requests/me/approve
  def approve
    @leave_requests = LeaveRequest.where(approver_id: @user.email).order('start_date')
    render json: @leave_requests
  end

  # GET /leave_requests/me/available_leave_days
  def available_leave_days; end

  # GET /leave_requests/all_taken
  def all_taken
    @leave_requests_taken = LeaveRequest.where(status: 'taken').order('start_date')
    render json: @leave_requests_taken
  end

  # GET /leave_requests/all_approved
  def all_approved
    @leave_requests_approved = LeaveRequest.where(status: 'approved').order('start_date')
    render json: @leave_requests_approved
  end

  # GET /leave_requests/taken_leaves
  def taken_leaves
    @leave_requests = LeaveRequest.where(status: 'taken')
                                  .where(initial_load: true)
                                  .where(employee_id: @user.email)
    render json: @leave_requests
  end

  # GET /leave_requests/1
  def show
    render json: @leave_request
  end

  # POST /leave_requests
  def create
    params = leave_request_params
    params[:employee_id] = @user.email
    @leave_request = LeaveService.create(params)
    if @leave_request.persisted?
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

  # GET /leave_requests/approved/1
  def approved
    @leave_request.status = 'approved'
    if @leave_request.save
      render json: @leave_request, status: :created, location: @leave_request
    else
      render json: @leave_request.errors, status: :unprocessable_entity
   end
   end

  # GET /leave_requests/rejected/1
  def rejected
    @leave_request.status = 'rejected'
    if @leave_request.save
      render json: @leave_request, status: :created, location: @leave_request
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
    params.require(:leave_request).permit(:employee_id, :start_date, :end_date, :return_date, :approver_id, :taken_days, :remaining_days, :total_days)
  end

  def leave_request_params_id
    params.require(:leave_request).permit(:id)
  end
end
