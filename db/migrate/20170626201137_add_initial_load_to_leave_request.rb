class AddInitialLoadToLeaveRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_requests, :initial_load, :boolean
  end
end
