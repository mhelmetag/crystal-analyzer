require "random"
require "file_utils"

module ExercismCfs
  class FileHandler
    def initialize(contents : String)
      id = Random.new.next_int
      @dirpath = "./tmp/file_#{id}"
      @filepath = "#{@dirpath}/code.cr"
      @contents = contents
    end

    def check_tmp_dir
      unless Dir.exists?(@dirpath)
        Dir.mkdir_p(@dirpath)
      end
    end

    def save_code_file
      check_tmp_dir
      File.write(@filepath, @contents)
      @filepath
    end

    def remove_tmp_dir
      if Dir.exists?(@dirpath)
        FileUtils.rm_r(@dirpath)
      end
    end
  end
end
