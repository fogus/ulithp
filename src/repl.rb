# by Russ Olsen
# http://eloquentruby.com

require 'lithp'
require 'reader'

lisp = Lisp.new

print "> "
while not $stdin.eof?
  line = readline
  s_expression = SExpressionParser.new(line).parse
  p lisp.eval(s_expression)
  print "> "
end
