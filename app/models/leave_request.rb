class LeaveRequest < ApplicationRecord
  enum status: [:pending, :approved, :rejected, :taken, :not_taken]
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :return_date

  validates_presence_of :taken_days
  validates_presence_of :remaining_days
  validates_presence_of :total_days

  validates :employee_id, presence: true,
                          format: {
                            with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                          }
  validates :approver_id, presence: true,
                          format: {
                            with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                          }
end
