# by Fogus
# http://joyofclojure.com

class Lisp
  def initialize
    @env = { 
      :label => lambda { |(name,val), _| @env[name] = val },
      :quote => lambda { |sexpr, _| sexpr[0] },
      :car   => lambda { |(list), _| list[0] },
      :cdr   => lambda { |(list), _| list.drop 1 },
      :cons  => lambda { |(e,cell), _| [e] + cell },
      :eq    => lambda { |(l,r), _| l == r },
      :if    => lambda { |(cond, thn, els), ctx| eval(cond, ctx) ? eval(thn, ctx) : eval(els, ctx) },
      :atom  => lambda { |(sexpr), _| (sexpr.is_a? Symbol) or (sexpr.is_a? Numeric) }
    }
  end

  def apply fn, args, ctx=@env
    return @env[fn].call(args, ctx) if @env[fn].respond_to? :call
    self.eval @env[fn][2], Hash[*(@env[fn][1].zip args).flatten(1)]
  end

  def eval sexpr, ctx=@env
    if @env[:atom].call [sexpr], ctx
      return ctx[sexpr] if ctx[sexpr]
      return sexpr
    end

    fn = sexpr[0]
    args = (sexpr.drop 1)
    args = args.map { |a| self.eval(a, ctx) } if not [:quote, :if].member? fn
    apply(fn, args, ctx)
  end
end

<<-LISP

l = Lisp.new

l.eval [:label, :a, 42]

l.eval :a
#=> 42

l.eval [:eq, 42, :a]
#=> true

l.eval [:quote, [1, 2]]
#=> [1, 2]

l.eval [:car, [:quote, [1, 2]]]
#=> 1

l.eval [:cdr, [:quote, [1, 2]]]
#=> [2]

l.eval [:cons, 1, [:quote, [2,3]]]
#=> [1, 2, 3]

l.eval [:if, [:eq, 1, 2], 42, 43]
#=> 43

l.eval [:atom, [:quote, [1,2]]]
#=> false

l.eval [:label, :second, [:quote, [:lambda, [:x], [:car, [:cdr, :x]]]]]

l.eval [:second, [:quote, [1, 2, 3]]]
#=> 2

LISP

