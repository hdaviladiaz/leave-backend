require 'csv'

class InitialDataLoader
  URL_DIRECTORY = '/../resources/'
  CSV_EXTENSION = '.csv'

  def load_csv_from_file (absolute_path, file_name)
    url_file = absolute_path + URL_DIRECTORY + file_name

    if File.file?(url_file) && url_file.include?(CSV_EXTENSION)
      csv_content = nil

      CSV.open(url_file) do |csv|
        csv_content = csv.find_all do |row|
          match = true
        end
      end
      return csv_content
    end

    return nil
  end
end
