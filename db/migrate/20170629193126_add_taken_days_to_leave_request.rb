class AddTakenDaysToLeaveRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_requests, :taken_days, :integer
  end
end
