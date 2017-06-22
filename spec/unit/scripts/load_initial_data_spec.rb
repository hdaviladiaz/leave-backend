require 'rails_helper'
require 'csv'

describe LoadInitialData do
  FILE_NAME = 'days_leave.csv'

  before(:each) do
    @load_initial_data = LoadInitialData. new
    @abosulute_path = File.expand_path('../', __FILE__)
  end

  describe '#load' do

    it 'should return a not nil array when the csv_file is loaded' do
      csv_file = @load_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      expect(csv_file).not_to be(nil)
    end

    it 'should return nil when the csv_file does not exist' do
      csv_file = @load_initial_data.load_csv_file(@abosulute_path, 'incorrect_file.csv')
      expect(csv_file).to be(nil)
    end

    it 'should remove the first line from csv_file when this is not the header' do
      header = ["No.", "TWER", "JIGSAW ID", "Fecha de Ingreso (MM/DD/AÑO)", "Derecho días de Vacación", "Días tomados al 31 Dic del 2016", "Ene 2017", "Feb 2017", "Mar 2017", "Abr 2017", "Total días tomados 2017", "Total días disponibles a la fecha (Ver celda C1)"]
      csv_file = @load_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      expect(csv_file[0]).to eq(header)
    end

    it 'should remove the last line from csv_file when this is total' do
      total = "TOTAL"
      csv_file = @load_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      expect(csv_file[csv_file.length - 1][1]).not_to eq(total)
    end

    it 'should return true when the csv_file is correct' do
      csv_file = @load_initial_data.load_csv_file(@abosulute_path, FILE_NAME)
      have_a_valid_format = @load_initial_data.have_a_valid_format(csv_file)
      expect(have_a_valid_format).to be(true)
    end



  end

end
