require "compiler/crystal/tools/formatter"

module CrystalAnalyzer
  module FormatChecker
    extend self

    def valid_format?(filepath : String)
      source = File.read(filepath)
      result = Crystal.format(source, filename: filepath)
      result == source
    end
  end
end
