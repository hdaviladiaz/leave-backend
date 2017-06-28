require 'rails_helper'

describe InitialDataValidator do

  FILE_NAME = 'days_leave.csv'
  FILE_NAME_WRONG = 'days_leave_wrong.csv'

  before(:each)do
    @initial_data_loader = InitialDataLoader. new
    @initial_data_validator = InitialDataValidator. new
    @absolute_path = File.expand_path('../', __FILE__)
  end

  describe '#validate' do
    it 'should return true when the csv_file is correct' do
      csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_NAME)
      have_a_valid_format = @initial_data_validator.have_a_valid_format(csv_file)
      expect(have_a_valid_format).to be(true)
    end

    it 'should return false when the csv file is wrong' do
      csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_NAME_WRONG)
      have_a_valid_format = @initial_data_validator.have_a_valid_format(csv_file)
      expect(have_a_valid_format).to be(false)
    end
  end
end
