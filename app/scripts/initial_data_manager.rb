class InitialDataManager

  FILE_NAME = 'days_leave.csv'

  def initialize()
    @initial_data_loader = InitialDataLoader. new
    @initial_data_processor = InitialDataProcessor. new
    @initial_data_validator = InitialDataValidator. new
    @absolute_path = File.expand_path('../', __FILE__)
    @header_simplified = ["JIGSAW ID","Fecha de Ingreso (MM/DD/AÑO)","Días tomados al 31 Dic del 2016","Total días tomados 2017"]
  end

  def get_initial_data_from_file()
    csv_file = @initial_data_loader.load_csv_from_file(@absolute_path, FILE_NAME)
    @initial_data_processor.remove_first_line_when_this_is_not_the_header(csv_file)
    @initial_data_processor.remove_the_last_line_when_this_is_total(csv_file)
    @initial_data_processor.build_custom_csv_file_with_required_fields(csv_file)
    @initial_data_processor.get_employee_information(csv_file, @header_simplified)
  end

end
