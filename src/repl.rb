require 'lithp'
require 'reader'

lisp = Lisp.new

if File.exist?("core.ulithp")
  source = File.open("core.ulithp", "r").read
  forms = Marshal.load(source)

  forms.each { |form| puts "#{form}" ; lisp.eval(form) }

  puts "Done loading core library containing #{forms.length} forms."
end

print "ulithp> "
while not $stdin.eof?
  line = readline
  s_expression = Reader.new(line).read
  p lisp.eval(s_expression)
  print "ulithp> "
end
