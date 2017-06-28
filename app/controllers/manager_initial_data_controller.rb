class ManagerInitialDataController < ApplicationController

  THOUGHTWORKS_DOMAIN = '@thoughtworks.com'
  INITIAL_DATA_APPROVER = 'mscudero@thoughtworks.com'

  def initialize
    @matrix_employee_information_data
  end

  def get_initial_data
    initial_data_manager = InitialDataManager. new
    matrix_employee_information_data = initial_data_manager.get_initial_data_from_file()
    return matrix_employee_information_data
  end

  def parse_row_data_to_json(row)
    dictionary_row = {'start_date' => build_start_date(row[2] + row[3]),
                      'end_date' => build_final_date,
                      'return_date' => build_final_date,
                      'employee_id' => row[0].to_s + THOUGHTWORKS_DOMAIN,
                      'approver_id' => INITIAL_DATA_APPROVER,
                      'initial_load' => true,
                      'status' => 'taken'
                    }
    return dictionary_row
  end

  def build_start_date(taken_leave_days)
    Date.today - taken_leave_days.to_i
  end

  def build_final_date()
    Date.today
  end

  def save_unique_leave_request(leave_request_params)
    leave_request = LeaveRequest.new(leave_request_params)
    return leave_request.save
  end

  def save_matrix_initial_data()
    @matrix_employee_information_data = get_initial_data
    for i in 0..(@matrix_employee_information_data.length - 1)
      row = @matrix_employee_information_data[i]
      if row[2].to_i + row[3].to_i > 0
        row_json = parse_row_data_to_json(row)
        save_unique_leave_request(row_json)
      end
    end
  end
end
