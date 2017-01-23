require "uri"
require "http/client"
require "json"

uri = URI.parse("http://localhost:3000/check")
headers = HTTP::Headers{"content-type" => "application/json"}

root = File.expand_path(File.join("..", ".."), __FILE__)
test_file = File.expand_path(File.join("spec", "fixtures", "formatted.cr"), root)
data = File.read(test_file)
body = {id: "test", contents: data}.to_json

HTTP::Client.post(uri, headers: headers, body: body) do |response|
  puts response.body_io.gets
end
