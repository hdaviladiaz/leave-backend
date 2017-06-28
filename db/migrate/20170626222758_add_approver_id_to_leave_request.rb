class AddApproverIdToLeaveRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_requests, :approver_id, :text
  end
end
