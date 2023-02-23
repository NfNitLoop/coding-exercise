Ruby Coding Exercise
====================

Usually I'd capture the purpose of a codebase in its README file but I'm going 
to not copy/paste the purpose of this codebase in case someone doesn't want it
to be easily google-able. `:)`

Running
-------

1. `bundle install`
2. `ruby main.rb $someNumber`

Testing
-------

`rake test`


What I'm Pleased With
---------------------

* Was happy to find that Ruby Enumerators have a built-in `.peek`. I feel like I've written my own Peekable classes in
  several languages before.

* Learned a good bit about the performance of prime number generation. Feels counterintuitive. Yay, tests!

* Got to brush up on my Ruby skills. `:)`

What I'd do with more time
--------------------------

 * Learn more about [RBS](https://github.com/ruby/rbs)
   * Do tools support it well enough now to make it worth the effort?  
     (The last time I played w/ Python type annotations, it wasn't worthwhile. TypeScript annotations are, though!)

 * Look into Enumerator/Enumerable oddities to better understand them.  
   TIL: Enumerators extend Enumerable, and `.take` for `Enumerable` is defined
   to always take from the start of a collection, so this resets (`.rewind`s?) the Enumerator. 😑
   Oddly/inconsistently, this does *not* seem to be the case for an `Enumerator::ArightmeticSequence`.
   I suppose that may be because it's easy to calculate any Nth element's value, so the implementation
   doesn't need to restart any Enumerator state to just (re)calculate the first N items.

 * Read up on RDoc and make sure everything is documented according to convention.

 * Try out a bitset implementation (ex: <https://github.com/tyler/bitset>) to see if it allows saving some memory w/o
   too much performance loss.

 * More performance optimizations (see TODO comments.)
   * also: Can use a different algorithm to use O(sqrt(n)) memory, w/ possible better performance.  
     see: <https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes#Segmented_sieve>