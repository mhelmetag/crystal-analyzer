require "file_utils"

module ExercismCfs
  module FileHandler
    extend self

    def check_dir(uuid : String)
      dirpath = "./tmp/#{uuid}"
      unless Dir.exists?(dirpath)
        Dir.mkdir_p(dirpath)
      end
    end

    def save_code_file(uuid : String, contents : String)
      check_dir(uuid)
      codepath = "./tmp/#{uuid}/code.cr"
      File.write(codepath, contents)
    end

    def read_json_file(uuid : String)
      jsonpath = "./tmp/#{uuid}/result.json"
      if File.exists?(jsonpath)
        File.read(jsonpath)
      end
    end

    def remove_dir(uuid : String)
      dirpath = "./tmp/#{uuid}"
      if Dir.exists?(dirpath)
        FileUtils.rm_r(dirpath)
      end
    end
  end
end
