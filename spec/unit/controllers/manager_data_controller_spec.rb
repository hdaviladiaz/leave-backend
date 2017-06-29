require 'rails_helper'

describe ManagerInitialDataController, type: :controller do

  before(:each) do
    @initial_data_manager = ManagerInitialDataController. new
    @matrix_employee_information_data = @initial_data_manager.get_initial_data()
  end

  let(:valid_attributes) {
    {
      start_date: Faker::Date.forward(10),
      end_date: Faker::Date.forward(10),
      return_date: Faker::Date.forward(10),
      employee_id: Faker::Internet.email,
      approver_id: Faker::Internet.email,
      taken_days: Faker::Number.between(1, 10),
      remaining_days: Faker::Number.between(1, 10),
      total_days: Faker::Number.between(1, 10),
      initial_load: true,
      status: 'taken'
    }
  }

  let(:valid_row){
    [
      Faker::Number.between(1, 9999),
      Faker::Date.forward(10),
      Faker::Number.between(1, 10),
      Faker::Number.between(1, 10)
    ]
  }

  describe '#save data' do

    it 'should load data matrix when initial data manager method is requested' do
      expect(@matrix_employee_information_data).not_to be(nil)
    end

    it 'should calculate start_date end_date and return_date when a row from matrix is processed' do
      first_element_json = @initial_data_manager.parse_row_data_to_json(valid_row)
      return_date = Date.today
      end_date = Date.today
      start_date = Date.today - (valid_row[2] + valid_row[3])
      expect(first_element_json['start_date']).to eq(start_date)
      expect(first_element_json['end_date']).to eq(end_date)
      expect(first_element_json['return_date']).to eq(return_date)
    end

    it 'should process first element of the initial data to generate json' do
      first_element_json = @initial_data_manager.parse_row_data_to_json(valid_row)
      isContained = first_element_json.key?('start_date') &&
                    first_element_json.key?('end_date') &&
                    first_element_json.key?('return_date') &&
                    first_element_json.key?('employee_id') &&
                    first_element_json.key?('initial_load') &&
                    first_element_json.key?('taken_days') &&
                    first_element_json.key?('remaining_days') &&
                    first_element_json.key?('total_days') &&
                    first_element_json.key?('status')
      expect(isContained).to be(true)
    end

    it 'should save an unique leave request non nil with leave information for a twer' do
      first_element_json = @initial_data_manager.parse_row_data_to_json(valid_row)
      leave_request_unique = @initial_data_manager.save_unique_leave_request(first_element_json)
      expect(leave_request_unique).not_to be(nil)
    end

    it 'should save in database when the taken days in before years are greater than zero with a initial data matrix' do
      numero_registros = 0
      for i in 0..(@matrix_employee_information_data.length - 1)
        row = @matrix_employee_information_data[i]
        if row[2].to_i + row[3].to_i > 0
          numero_registros = numero_registros + 1
        end
      end
      expect{@initial_data_manager.save_matrix_initial_data()}.to change(LeaveRequest, :count).by(numero_registros)
    end

  end

end
