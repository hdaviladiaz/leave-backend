class LeaveService
  def createLeaveRequest(leave_request)
    startDate = (leave_request["result"]["startDate"]).to_date
    endDate = (leave_request["result"]["endDate"]).to_date
    hiredDate = (leave_request["result"]["hireDate"]).to_date
    today = DateTime.now

    if startDate > endDate
      return 'Error! The start date is greater than end date'
    elsif startDate < today then
      return 'Error! The start date is smaller than today'
    elsif startDate < hiredDate then
      return 'Error! The start date is smaller than hired date'
    else
      return 'Success!'
    end

  end
end
