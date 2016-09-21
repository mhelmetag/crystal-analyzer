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
  env.response.content_type = "application/json"
  uuid = env.params.json["uuid"].to_s
  contents = env.params.json["contents"].to_s
  ExercismCfs::FileHandler.save_code_file(uuid, contents)
  ExercismCfs::FormatChecker.check_code_file(uuid)
  result = ExercismCfs::FileHandler.read_json_file(uuid)
  ExercismCfs::FileHandler.remove_dir(uuid)

  {uuid: uuid, result: result}
end

Kemal.run
