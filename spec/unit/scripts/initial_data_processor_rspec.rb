require 'rails_helper'

describe InitialDataProcessor do

  FILE_NAME = 'days_leave.csv'

  before(:each)do
    @initial_data_loader = InitialDataLoader. new
    @initial_data_processor = InitialDataProcessor. new
    @initial_data_validator = InitialDataValidator. new
    @absolute_path = File.expand_path('../', __FILE__)
    @csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_NAME)
    @header_simplified = ["JIGSAW ID","Fecha de Ingreso (MM/DD/AÑO)","Días tomados al 31 Dic del 2016","Total días tomados 2017"]
  end

  describe '#process' do
    it 'should remove the first line from csv_file when this is not the header' do
      header = ["No.", "TWER", "JIGSAW ID", "Fecha de Ingreso (MM/DD/AÑO)", "Derecho días de Vacación", "Días tomados al 31 Dic del 2016", "Ene 2017", "Feb 2017", "Mar 2017", "Abr 2017", "Total días tomados 2017", "Total días disponibles a la fecha (Ver celda C1)"]
      @initial_data_processor.remove_first_line_when_this_is_not_the_header(@csv_file)
      expect(@csv_file[0]).to eq(header)
    end

    it 'should remove the last line from csv_file when this is total' do
      total = "TOTAL"
      @initial_data_processor.remove_the_last_line_when_this_is_total(@csv_file)
      expect(@csv_file[@csv_file.length - 1][1]).not_to eq(total)
    end

    it 'should get custom employee information when the file is correctly loaded' do
      csv_file_process = @initial_data_processor.get_employee_information(@csv_file, @header_simplified)
      expect(@csv_file.length).to be(csv_file_process.length)
    end

    it 'should have the correct number of fields when the file is correctly loaded' do
      csv_file_process = @initial_data_processor.get_employee_information(@csv_file, @header_simplified)
      num_fields_correct = @initial_data_validator.check_num_fields(csv_file_process)
      expect(num_fields_correct).to be(true)
    end

  end
end
