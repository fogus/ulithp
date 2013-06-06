# μLithp

### [Official website and deep analysis](http://fogus.github.com/ulithp)

A micro LISP implementation in 25 lines of Ruby, with a reader in 33 lines, REPL in 35 lines, a compiler in 15 lines and Ruby interop in 13 lines.  Really frickin' small.

* `car`
* `cdr`
* `quote`
* `atom`
* `if`
* `label`
* `cons`
* `eq`
* `lambda`

See the `src/lithp.rb` file for source and `doc/index.org` for implementation details and the original announcement in the  [μLithp blog post](http://blog.fogus.me/2012/01/25/lisp-in-40-lines-of-ruby/).

*this is my entry into the December 2012 [PLT Games](http://www.pltgames.com)*

## Embedded usage

The LISP interpreter is just a Ruby class that evals expressions in Ruby data structures, like so:

```ruby
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

	 l.eval [:label, :second, [:quote, [:lambda, [:x], 	 [:car, [:cdr, :x]]]]]

	 l.eval [:second, [:quote, [1, 2, 3]]]
	 #=> 2
```

Have fun!

## REPL usage

In your shell use Ruby 1.9.2 to run the REPL:

```sh
    rvm use ruby-1.9.2
	ruby -I . repl.rb
```

You'll then see a prompt:

    >

Start typing uLithp code:

```lisp
    (car (quote (1 2 3)))

	(cdr (quote (1 2 3)))

	(label third (quote (lambda (x) (car (cdr (cdr x))))))
	(third (quote (1 2 3 4 5)))
```

Enjoy!

## thanks

Thanks to [Russ Olsen](http://eloquentruby.com) for the reader and REPL.

## License

This software is provided as-is under the [MIT license](http://opensource.org/licenses/MIT).
