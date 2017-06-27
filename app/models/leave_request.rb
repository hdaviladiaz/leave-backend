class LeaveRequest < ApplicationRecord
  enum status: [:pending, :approved, :rejected, :taken, :not_taken]
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :return_date
  validates_presence_of :employee_id
end
