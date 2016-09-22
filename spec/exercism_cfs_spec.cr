require "./spec_helper"

describe "ExercismCfs" do
  describe "FormatChecker" do
    describe "#check" do
      it "finds problems with unformatted file" do
        filepath = "./spec/fixtures/error_file.cr"
        result = ExercismCfs::FormatChecker.check_code_file(filepath)
        result.should eq false
      end

      it "finds no problems with a formatted file" do
        filepath = "./spec/fixtures/no_error_file.cr"
        result = ExercismCfs::FormatChecker.check_code_file(filepath)
        result.should eq true
      end
    end
  end
end
