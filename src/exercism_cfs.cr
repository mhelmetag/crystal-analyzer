require "./exercism_cfs/*"

require "kemal"
require "json"

get "/" do |env|
  env.response.content_type = "application/json"
  name = env.params.query["name"]?
  if name
    {result: "Hello, #{name}"}
  else
    {result: "Hello, Exercism"}
  end
end

get "/version" do |env|
  env.response.content_type = "application/json"
  {version: ExercismCfs::VERSION}
end

post "/check" do |env|
  begin
    env.response.content_type = "application/json"
    id = env.params.json["id"]?.to_s
    contents = env.params.json["contents"]?.to_s
    if id && contents
      file_handler = ExercismCfs::FileHandler.new(contents)
      filepath = file_handler.save_code_file
      formatted = ExercismCfs::FormatChecker.check_code_file(filepath)
      result = if formatted
                 "formatted"
               else
                 "unformatted"
               end
      file_handler.remove_tmp_dir
      {id: id, result: result}
    else
      env.response.status_code = 400
      {error: "you must supply an id and file content"}
    end
  rescue error : Exception
    env.response.status_code = 666
    {error: error.message}
  end
end

Kemal.run
