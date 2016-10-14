require "./exercism_cfs/*"

require "kemal"
require "json"

get "/" do |env|
  env.response.content_type = "application/json"
  name = env.params.query["name"]?
  if name
    {result: "Hello, #{name}"}.to_json
  else
    {result: "Hello, Crystal"}.to_json
  end
end

get "/version" do |env|
  env.response.content_type = "application/json"
  {version: ExercismCfs::VERSION}.to_json
end

post "/check" do |env|
  env.response.content_type = "application/json"
  begin
    id = env.params.json["id"]?.to_s
    contents = env.params.json["contents"]?.to_s
    if id && contents
      file_handler = ExercismCfs::FileHandler.new(contents)
      filepath = file_handler.save_code_file
      unformatted = ExercismCfs::FormatChecker.valid_format?(filepath)
      result = if unformatted
                 "true"
               else
                 "false"
               end
      file_handler.remove_tmp_dir
      env.response.status_code = 200
      problems = [{type: "unformatted", result: result}]
      {problems: problems, error: ""}.to_json
    else
      env.response.status_code = 400
      {problems: [] of String, error: "you must supply an id and file content"}.to_json
    end
  rescue error : Exception
    env.response.status_code = 666
    {problems: [] of String, error: error.message}.to_json
  end
end

Kemal.run
