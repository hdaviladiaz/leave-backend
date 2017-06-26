class InitialDataValidator

  NUM_COLUMN_CUSTOM = 4
  NUM_COLUMN_CSV = 12

  def have_a_valid_format (file)
    file.each do |row|
      if row.length != NUM_COLUMN_CSV
        return false
      end
    end
    return true
  end

  def check_num_fields(csv_file_process)
    for i in (0..csv_file_process.length - 1)
      if csv_file_process[i].length != NUM_COLUMN_CUSTOM
        return false
      end
    end
    return true
  end

end
