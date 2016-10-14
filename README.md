# Exercism CFS
## Description/Usage
Tiny format checking service for Crystal files.

Give it a ID and the contents of a file and it'll tell you if it's formatted or not.

## Example Files
### Unformatted
```crystal
class Dog
  def initialize(name)
    @name =       name
  end

      def say
  puts "Hello, this is #{name}"
      end
end
```

### Formatted
```crystal
class Dog
  def initialize(name)
    @name = name
  end

  def say
    puts "Hello, this is #{name}"
  end
end
```

## Example Client
### Client Code
```ruby
require 'uri'
require 'net/http'
require 'json'
require 'securerandom'

url = URI("http://localhost:3000/check")

file = open("./spec/fixtures/no_error_file.cr")

http = Net::HTTP.new(url.host, url.port)

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request.body = {id: SecureRandom.uuid, contents: file.read}.to_json

response = http.request(request)
puts response.read_body
```

### Client Response (Unformatted)
```json
{"id": "d96b02cd-4b22-452a-8f54-a8b4819fc457", "result": "unformatted"}
```

### Client Response (Formatted)
```json
{"id": "cd35fe13-9196-4aa3-bcd8-9b8ea3984b20", "result": "formatted"}
```
