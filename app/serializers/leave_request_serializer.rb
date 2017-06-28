class LeaveRequestSerializer < ActiveModel::Serializer
  attributes :id, :employee_id, :start_date, :end_date, :return_date, :approver_id, :status, :employee_name
end
