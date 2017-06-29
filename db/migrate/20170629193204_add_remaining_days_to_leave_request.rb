class AddRemainingDaysToLeaveRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_requests, :remaining_days, :integer
  end
end
