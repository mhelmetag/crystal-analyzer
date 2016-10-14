# Exercism CFS
## Description/Usage
Tiny format checking service for Crystal files.

Give it a ID and the contents of a file and it'll tell you if it's formatted or not.

Deployed at: `https://glacial-thicket-22416.herokuapp.com`

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
```crystal
require "uri"
require "http/client"
require "json"

uri = URI.parse("http://localhost:3000/check")

text = File.read("spec/fixtures/no_error_file.cr")

body = {id: "whatever", contents: text}.to_json
headers = HTTP::Headers{"content-type" => "application/json"}
HTTP::Client.post(uri, headers: headers, body: body) do |response|
  puts response.body_io.gets
end
```

### Client Response Success (Unformatted)
```json
{"problems": [{"type": "unformatted", "result": "true"}], "error": ""}
```

### Client Response Success (Formatted)
```json
{"problems": [{"type": "unformatted", "result": "false"}], "error": ""}
```

### Client Response Failure
```json
{"problems": [], "error": "you must supply an id and file content"}
```
