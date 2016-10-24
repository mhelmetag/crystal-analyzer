require "uri"
require "http/client"
require "json"

uri = URI.parse("http://localhost:3000/check")
text = File.read("spec/fixtures/error_file.cr")
body = {id: "test.cr", contents: text}.to_json
headers = HTTP::Headers{"content-type" => "application/json"}

HTTP::Client.post(uri, headers: headers, body: body) do |response|
  puts response.body_io.gets
end
