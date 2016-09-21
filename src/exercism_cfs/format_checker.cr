module ExercismCfs
  module FormatChecker
    extend self

    def check_code_file(uuid : String)
      dirpath = "./tmp/#{uuid}"
      system %(crystal tool format -f json #{dirpath}/code.cr > #{dirpath}/result.json)
    end
  end
end
