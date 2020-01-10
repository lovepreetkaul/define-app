###############################################################################
# define: Command line based dictionary, potentially also urban dictionary,
# and Wikipedia.
# 
# TODO:
#
#- Implement basic commandline argument parsing.
#- Implement a simple json based dictionary API.
#- Make it modular.
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

if options[:word].nil? or ARGV.length == 0 
  STDERR.puts("Required argument -w WORD. Please see help using -h")
  exit(1)
end

puts "Results:"
puts "#{word}"
