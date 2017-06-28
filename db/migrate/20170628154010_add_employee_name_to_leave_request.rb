class AddEmployeeNameToLeaveRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_requests, :employee_name, :text
  end
end
