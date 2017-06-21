class LeaveRequest < ApplicationRecord
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :return_date
  validates_presence_of :employee_id
end
