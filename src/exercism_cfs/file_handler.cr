module ExercismCfs
  module FileHandler
    extend self

    def save_file(uuid : String, contents : String)
      check_code_dir(uuid)
      filepath = "./tmp/#{uuid}/code.cr"
      File.write(filepath, contents)
      filepath
    end

    def remove_dir(uuid : String)
      dirpath = "./tmp/#{uuid}"
      if Dir.exists?(dirpath)
        FileUtils.rm_r(dirpath)
      end
    end

    def check_tmp_dir(uuid : String)
      dirpath = "./tmp/#{uuid}"
      unless Dir.exists?(dirpath)
        Dir.mkdir_p(dirpath)
      end
    end
  end
end
