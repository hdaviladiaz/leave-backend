require 'csv'

class ManagerInitialData
  URL_DIRECTORY = '/../resources/'
  NUM_COLUMN_CSV = 12
  CSV_EXTENSION = '.csv'

  def load_csv_file (abosulute_path, file_name)
    url_file = abosulute_path + URL_DIRECTORY + file_name

    if File.file?(url_file) && url_file.include?(CSV_EXTENSION)
      csv_content = nil

      CSV.open(url_file) do |csv|
        csv_content = csv.find_all do |row|
          match = true
        end
      end

      remove_first_line_when_this_is_not_the_header(csv_content)
      remove_the_last_line_when_this_is_total(csv_content)
      return csv_content
    end

    return nil
  end

  def remove_first_line_when_this_is_not_the_header (csv_content)
    csv_content.shift
  end

  def remove_the_last_line_when_this_is_total (csv_content)
    csv_content.pop(1)
  end

  def have_a_valid_format (file)
    file.each do |row|
      if row.length != NUM_COLUMN_CSV
        return false
      end
    end
    return true
  end

  def get_employee_information (csv_file, header)
    csv_file_process = []

    index_jigsaw_id = 0
    index_hire_date = ''
    index_last_year_taken_leave = 0
    index_current_year_taken_leave = 0

    current_header_array = csv_file[0]

    (0..current_header_array.length).each do |i|
      if current_header_array[i] == 'JIGSAW ID'
        index_jigsaw_id = i
      elsif current_header_array[i] == 'Fecha de Ingreso (MM/DD/AÑO)'
        index_hire_date = i
      elsif current_header_array[i] == 'Días tomados al 31 Dic del 2016'
        index_last_year_taken_leave = i
      elsif current_header_array[i] == 'Total días tomados 2017'
        index_current_year_taken_leave = i
    end

    (0..csv_file.length).each do |i|
      csv_file_process.push(csv_file[index_jigsaw_id], csv_file[index_hire_date], csv_file[index_last_year_taken_leave], csv_file[index_current_year_taken_leave])
    end

    return csv_file_process
  end

end
