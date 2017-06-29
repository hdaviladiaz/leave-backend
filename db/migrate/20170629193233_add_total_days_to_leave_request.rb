class AddTotalDaysToLeaveRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_requests, :total_days, :integer
  end
end
