class InitialDataProcessor

  def initialize()
    @index_jigsaw_id = 0
    @index_hire_date = 0
    @index_last_year_taken_leave = 0
    @index_current_year_taken_leave = 0
  end

  def get_employee_information (csv_file, header)
    remove_first_line_when_this_is_not_the_header(csv_file)
    remove_the_last_line_when_this_is_total(csv_file)
    current_header_array = csv_file[0]

    (0..current_header_array.length).each do |i|
      if current_header_array[i] == 'JIGSAW ID'
        @index_jigsaw_id = i
      elsif current_header_array[i] == 'Fecha de Ingreso (MM/DD/AÑO)'
        @index_hire_date = i
      elsif current_header_array[i] == 'Días tomados al 31 Dic del 2016'
        @index_last_year_taken_leave = i
      elsif current_header_array[i] == 'Total días tomados 2017'
        @index_current_year_taken_leave = i
      end
    end
    return build_custom_csv_file_with_required_fields(csv_file)
  end

  def build_custom_csv_file_with_required_fields(csv_file)
    csv_file_process = []

    (0..(csv_file.length - 1)).each do |i|
      jigsaw_id = csv_file[i][@index_jigsaw_id]
      hire_date = csv_file[i][@index_hire_date]
      last_taken_leave = csv_file[i][@index_last_year_taken_leave]
      current_taken_leave = csv_file[i][@index_current_year_taken_leave]
      csv_file_process.push([jigsaw_id, hire_date, last_taken_leave, current_taken_leave])
    end
    return csv_file_process
  end

  def remove_first_line_when_this_is_not_the_header (csv_content)
    csv_content.shift
  end

  def remove_the_last_line_when_this_is_total (csv_content)
    csv_content.pop(1)
  end

end
