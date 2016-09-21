require "./exercism_cfs/*"

require "kemal"
require "json"

get "/" do |env|
  name = env.params.query["name"]
  if name != nil
    "Hello, #{name}"
  else
    "Hello, Exercism"
  end
end

get "/version" do
  ExercismCfs::VERSION
end

post "/check" do |env|
  env.response.content_type = "application/json"
  uuid = env.params.json["uuid"]
  contents = env.params.json["contents"]

  ExercismCfs::FileHandler.save_to_file(uuid, contents)
  ExercismCfs::FormatChecker.check_file(uuid)
  ExercismCfs::FileHandler.remove_file(uuid)

  {uuid: uuid, result: result}
end
