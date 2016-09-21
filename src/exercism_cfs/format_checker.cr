module ExercismCfs
  module FormatChecker
    def check_file(uuid : String)
      dirpath = "./tmp/#{uuid}"
      system %(crystal tool format -f json #{dirpath}/code.cr > #{dirpath}/result.json)
    end
  end
end
