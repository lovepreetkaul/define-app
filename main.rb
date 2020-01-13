###############################################################################
# define: Command line based dictionary, potentially also urban dictionary,
# and Wikipedia.
# 
# TODO:
#
#- Implement basic commandline argument parsing.
#- Implement a simple json based dictionary API.
#- Make it modular.
#- Add Error handling.
#- Add multiple dictionary sources.
#- Add a fallback dictionary that is offline and always available.
#- Create a configuration file.
#- Package it.
#- Upload to AUR.
#- Add Urban dictionary search.
#- Add Wikipedia search.
#- Add more complex command line based operations
#
###############################################################################


require 'optparse'
require 'faraday'
require 'json'

options = {}

OptionParser.new do |parser|
  
  parser.on("-h","--help", "Show this help message") do ||
    options[:help] = true
    puts parser
    exit
  end
  
  parser.on("-w","--word WORD", "The word you need the definition for") do |w|
    options[:word] = w
  end

end.parse!

if options[:word].nil?  
  STDERR.puts("Required argument -w WORD. Please see help using -h")
  exit(1)
end

# Tentative Oxford dictionary implementation

# API Credentials
app_id = "d4367e28"
app_key = "12767b5940fca4f676b4cfeb84ac9f0f"

url = "https://od-api.oxforddictionaries.com/api/v2/"
lang_code = "en-us"
endpoint = "entries"
fields = "definitions"

word_id = options[:word]
complete_url = url << endpoint << '/' << lang_code << '/' << word_id.downcase << '?fields=' << fields 
response = Faraday.get(complete_url) do |req|
  req.headers['app_id'] = app_id
  req.headers['app_key'] = app_key
end

if response.status != 200
  STDERR.puts("Some error occured");
  exit(127)
end
puts response.body
json = JSON.parse(response.body)


