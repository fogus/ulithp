# uLithp

A micro LISP implementation in ~30 lines of Ruby, with a reader in 32 lines, and a REPL in 12 lines.  Rreally frickin' small.

See the lithp.rb file for implementation details.

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
    (car (quote 1 2 3))
	
	(cdr (quote 1 2 3))
```

Enjoy!

## thanks

Thanks to [Russ Olsen](http://eloquentruby.com) for the reader and REPL.
