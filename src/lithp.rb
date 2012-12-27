
class Lisp

def initialize

@env = { :label => lambda { |(name,val), _| @env[name] = val },

:car   => lambda { |(list), _| list[0] },

:cdr   => lambda { |(list), _| list.drop 1 },

:cons  => lambda { |(e,cell), _| [e] + cell },

:eq    => lambda { |(l,r), _| l == r },

:if    => lambda { |(cond, thn, els), ctx| eval(cond, ctx) ? eval(thn, ctx) : eval(els, ctx) },

:atom  => lambda { |(sexpr), _| (sexpr.is_a? Symbol) or (sexpr.is_a? Numeric) },

:quote => lambda { |sexpr, _| sexpr[0] } }

end

def apply fn, args, ctx=@env

return ctx[fn].call(args, ctx) if ctx[fn].respond_to? :call

self.eval ctx[fn][2], Hash[*(ctx[fn][1].zip args).flatten(1)]

end

def eval sexpr, ctx=@env

if ctx[:atom].call [sexpr], ctx

return ctx[sexpr] || sexpr

end

fn, *args = sexpr

args = args.map { |a| self.eval(a, ctx) } if not [:quote, :if].member? fn

apply(fn, args, ctx)

end

end
