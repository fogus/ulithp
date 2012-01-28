# uLithp

A micro LISP implementation in ~30 lines of Ruby, with a reader in 32 lines, and a REPL in 12 lines.  Really frickin' small.

* `car`
* `cdr`
* `quote`
* `atom`
* `if`
* `label`
* `cons`
* `eq`
* `λ`

See the lithp.rb file for implementation details and the [uLithp blog post](http://blog.fogus.me/2012/01/25/lisp-in-40-lines-of-ruby/).

## usage

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
	
	(label second (quote (λ (x) (car (cdr x))))) 
	(second (quote (1 2 3)))
```

Enjoy!

## thanks

Thanks to [Russ Olsen](http://eloquentruby.com) for the reader and REPL.
