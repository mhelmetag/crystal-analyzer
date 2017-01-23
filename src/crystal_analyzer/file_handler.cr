require "random"
require "file_utils"

module CrystalAnalyzer
  class FileHandler
    def initialize(contents : String)
      @contents = contents
    end

    def check_tmp_dir
      unless Dir.exists?(tempdir)
        Dir.mkdir_p(tempdir)
      end
    end

    def save_code_file
      check_tmp_dir
      File.write(tempfile, @contents)
      tempfile
    end

    def remove_tmp_dir
      if Dir.exists?(tempdir)
        FileUtils.rm_r(tempdir)
      end
    end

    def root
      @root ||= File.expand_path(File.join("..", "..", ".."), __FILE__)
    end

    def tempdir
      @tempdir ||= File.expand_path(file_id, root)
    end

    def tempfile
      @tempfile ||= File.join(tempdir, "code.cr")
    end

    def file_id
      @file_id ||= "file_#{Random.new_seed}"
    end
  end
end
