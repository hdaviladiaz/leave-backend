class AddStatusToLeaveRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_requests, :status, :integer
  end
end
