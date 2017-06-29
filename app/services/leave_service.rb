require 'json'
class LeaveService
  def self.create(leave_request_params)
    leave_request = build_leave_request(leave_request_params)
    send_confirmation_email(leave_request) if leave_request.save
    leave_request
  end

  def self.build_leave_request(leave_request_params)
    leave_request = LeaveRequest.new(leave_request_params)
    jigsaw_info(leave_request)
    leave_request.taken_days = 10
    leave_request.remaining_days = 20
    leave_request.total_days = 30
    leave_request.status = 'pending'
    leave_request
  end

  def self.jigsaw_info(leave_request)
    people_service = PeopleService.new
    user = User.new(leave_request.employee_id)
    jigsaw_result = people_service.get_by_username(user.username)
    jigsaw_user = JSON.parse(jigsaw_result)
    leave_request.employee_name = jigsaw_user['preferredName']
  end

  def self.send_confirmation_email(_leave_request); end
  private_class_method :build_leave_request, :send_confirmation_email
end
