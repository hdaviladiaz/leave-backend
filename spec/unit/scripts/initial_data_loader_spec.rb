require 'rails_helper'
require 'csv'

describe InitialDataLoader do

  FILE_NAME = 'days_leave.csv'
  FILE_NAME_NOT_CSV = 'holamundo.txt'
  FILE_DONT_EXISTS = 'incorrect_file.csv'

  before(:each) do
    @initial_data_loader = InitialDataLoader. new
    @absolute_path = File.expand_path('../', __FILE__)
  end

  describe '#load' do

    it 'should return a nil when the file loaded is a csv file' do
      csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_NAME_NOT_CSV)
      expect(csv_file).to be(nil)
    end

    it 'should return a not nil array when the csv_file is loaded' do
      csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_NAME)
      expect(csv_file).not_to be(nil)
    end

    it 'should return nil when the csv_file does not exist' do
      csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_DONT_EXISTS)
      expect(csv_file).to be(nil)
    end
  end
end
