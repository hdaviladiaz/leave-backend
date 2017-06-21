class LeaveRequestSerializer < ActiveModel::Serializer
  attributes :id, :employee_id, :start_date, :end_date, :return_date
end
