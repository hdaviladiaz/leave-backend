require 'csv'

class LoadInitialData
  URL_DIRECTORY = '/../resources/'

  def load_csv_file (abosulute_path, file_name)
    url_file = abosulute_path + URL_DIRECTORY + file_name

    if File.file?(url_file)
      csv_content = nil
      csv_headers = nil

      CSV.open(url_file) do |csv|
        csv_content = csv.find_all do |row|
          match = true
        end
        csv_headers = csv.headers
      end

      remove_first_line_when_this_is_not_the_header(csv_content)
      remove_the_last_line_when_this_is_total(csv_content)

      #csv_content.each do |row|
      #  p('**')
      #  p(row.length)
      #  row = row
      #  puts row
      #end



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

    return true
  end

end
