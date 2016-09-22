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
    puts "env: #{env.params}"
    uuid = env.params.json["uuid"]?.to_s
    puts "uuid: #{uuid}"
    contents = env.params.json["contents"]?.to_s
    puts "contents:\n#{contents}"
    if uuid && contents
      file_handler = ExercismCfs::FileHandler.new(uuid, contents)
      filepath = file_handler.save_code_file
      result = ExercismCfs::FormatChecker.check_code_file(filepath) ? "formatted" : "unformatted"
      file_handler.remove_tmp_dir
      {uuid: uuid, result: result}
    else
      env.response.status_code = 400
      {error: "you must supply a uuid and file contents"}
    end
  rescue error : Exception
    env.response.status_code = 666
    {error: error.message}
  end
end

Kemal.run
