require 'rails_helper'
require 'csv'

describe ManagerInitialData do
  FILE_NAME = 'days_leave.csv'
  FILE_NAME_NOT_CSV = 'holamundo.txt'
  FILE_NAME_WRONG = 'days_leave_wrong.csv'
  FILE_DONT_EXISTS = 'incorrect_file.csv'

  before(:each) do
    @manager_initial_data = ManagerInitialData. new
    @abosulute_path = File.expand_path('../', __FILE__)
    @header_simplified = ["JIGSAW ID", "Fecha de Ingreso (MM/DD/AÑO)", "Días tomados al 31 Dic del 2016", "Total días tomados 2017"]

  end

  describe '#load' do

    it 'should return a nil when the file loaded is a csv file' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME_NOT_CSV)
      expect(csv_file).to be(nil)
    end

    it 'should return a not nil array when the csv_file is loaded' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      expect(csv_file).not_to be(nil)
    end

    it 'should return nil when the csv_file does not exist' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_DONT_EXISTS)
      expect(csv_file).to be(nil)
    end

    it 'should remove the first line from csv_file when this is not the header' do
      header = ["No.", "TWER", "JIGSAW ID", "Fecha de Ingreso (MM/DD/AÑO)", "Derecho días de Vacación", "Días tomados al 31 Dic del 2016", "Ene 2017", "Feb 2017", "Mar 2017", "Abr 2017", "Total días tomados 2017", "Total días disponibles a la fecha (Ver celda C1)"]
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      expect(csv_file[0]).to eq(header)
    end

    it 'should remove the last line from csv_file when this is total' do
      total = "TOTAL"
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      expect(csv_file[csv_file.length - 1][1]).not_to eq(total)
    end

    it 'should return true when the csv_file is correct' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      have_a_valid_format = @manager_initial_data.have_a_valid_format(csv_file)
      expect(have_a_valid_format).to be(true)
    end

    it 'should return false when the csv file is wrong' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME_WRONG)
      have_a_valid_format = @manager_initial_data.have_a_valid_format(csv_file)
      expect(have_a_valid_format).to be(false)
    end

    it 'should get employee_id, hire date, leaves to december 2016, leaves 2017  and total leaves when the file is loaded correctly' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      csv_file_process = @manager_initial_data.get_employee_information(csv_file, @header_simplified)
      expect(csv_file_process[0]).to eq(@header_simplified)
    end

    it 'should get custom employee information when the file is correctly loaded' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      csv_file_process = @manager_initial_data.get_employee_information(csv_file, @header_simplified)
      expect(csv_file.length).to be(csv_file_process.length)
    end

    it 'should have the correct number of fields when the file is correctly loaded' do
      csv_file = @manager_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      csv_file_process = @manager_initial_data.get_employee_information(csv_file, @header_simplified)
      (0..csv_file.length).each do |i|
        expect(csv_file[i].length).to be(4)
      end
    end

  end

end
