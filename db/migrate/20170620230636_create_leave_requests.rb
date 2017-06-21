class CreateLeaveRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :leave_requests do |t|
      t.text :employee_id
      t.date :start_date
      t.date :end_date
      t.date :return_date

      t.timestamps
    end
  end
end
