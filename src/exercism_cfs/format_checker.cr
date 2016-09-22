module ExercismCfs
  module FormatChecker
    extend self

    def check_code_file(filepath : String)
      system %(crystal tool format --check #{filepath})
    end
  end
end
