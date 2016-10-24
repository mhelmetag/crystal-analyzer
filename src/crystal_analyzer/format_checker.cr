module CrystalAnalyzer
  module FormatChecker
    extend self

    def valid_format?(filepath : String)
      system %(crystal tool format --check #{filepath})
    end
  end
end
