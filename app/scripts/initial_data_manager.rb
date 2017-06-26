class InitialDataManager


  def initialize()
    @initial_data_loader = InitialDataLoader. new
    @initial_data_processor = InitialDataProcessor. new
  end


  def manage_initial_data
    csv_file = @initial_data_loader.load_csv_from_file(absolute_path, file_name)
    csv_file_without_header = remove_first_line_when_this_is_not_the_header(csv_file)
    csv_file_without_footer = remove_the_last_line_when_this_is_total(csv_file_without_header)


  end
end
