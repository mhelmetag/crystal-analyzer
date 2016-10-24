# Crystal Analyzer
## Description/Usage
Tiny format checking service for Crystal files.

Give it an ID and the contents of a crystal file and it'll tell you if it's formatted or not.

Deployed at: `https://glacial-thicket-22416.herokuapp.com`

## Todo
Extend the functionality to parse files to give feedback for general code smells and Crystal specific improvements.

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
Found in `examples/client.cr`

```crystal
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
```

### Client Response Success (Unformatted)
```json
{"id": "test.cr", "problems": [{"type": "unformatted", "result": "true"}], "error": ""}
```

### Client Response Success (Formatted)
```json
{"id": "test.cr", "problems": [{"type": "unformatted", "result": "false"}], "error": ""}
```

### Client Response Failure
```json
{"id": "test.cr", "problems": [], "error": "you must supply an id and file content"}
```
