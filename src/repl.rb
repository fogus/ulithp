
require 'lithp'
require 'reader'

lisp = Lisp.new

print "> "
while not $stdin.eof?
  line = readline
  s_expression = Reader.new(line).read
  p lisp.eval(s_expression)
  print "> "
end
