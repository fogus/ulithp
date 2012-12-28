
require 'lithp'

class ULithp < Lisp
  def initialize()

    @add = {:new => proc { |(klass, *args), ctx| 
                              eargs = args.map { |a| self.eval(a, ctx) }
                              Kernel.const_get(klass).new(*eargs)},  

            :invoke => proc { |(instance, meth, *args), ctx| 
                              eargs = args.map { |a| self.eval(a, ctx) }
                              einst = self.eval(instance, ctx)
                              einst.send(meth, *args)}
    }

    super(@add)
  end
end
