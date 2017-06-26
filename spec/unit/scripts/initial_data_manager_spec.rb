require 'rails_helper'
require 'csv'

describe InitialDataManager do

  FILE_NAME = 'days_leave.csv'


  before(:each) do
    @initial_data_manager = InitialDataManager. new
    @initial_data_loader = InitialDataLoader. new
    @initial_data_validator = InitialDataValidator. new
    @absolute_path = File.expand_path('../', __FILE__)
  end

  describe '#manage' do

    it 'should return a custom rows when the original data is loaded' do
      csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_NAME)
      expect(@initial_data_manager.get_initial_data_from_file().length).to eq(csv_file.length - 2)
    end

    it 'should return a custom columns whe the original data is loaded' do
      csv_file = @initial_data_manager.get_initial_data_from_file()
      expect(@initial_data_validator.check_num_fields(csv_file)).to be(true)
    end

  end
end
