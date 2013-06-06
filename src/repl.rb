require 'readline'
require 'lithp'
require 'reader'

# Exit gracefully with ctrl-c
stty_save = `stty -g`.chomp
trap('INT') { system('stty', stty_save); exit }

lisp = Lisp.new

if File.exist?("core.ulithp")
  source = File.open("core.ulithp", "r").read
  forms = Marshal.load(source)

  forms.each { |form| puts "#{form}" ; lisp.eval(form) }

  puts "Done loading core library containing #{forms.length} forms."
end

loop do
  line = Readline.readline("ulithp> ", true)
  exit if line =~ /^exit$/i

  begin
    s_expression = Reader.new(line).read
    p lisp.eval(s_expression)
  rescue Exception => error
    # ANSI escaped red
    puts "\e[31m"
    puts "on #{error.backtrace.pop}: #{error.message}"
    puts error.backtrace.map { |line| "\tfrom:#{line} " }
    # Clear ANSI escapes
    print "\e[0m"
  end
end
