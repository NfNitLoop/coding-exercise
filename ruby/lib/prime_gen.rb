module PrimeGen

    ##
    # Returns an Enumerator that yields prime numbers up to `max_prime`.
    #
    # See: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
    #
    # This implementation has O(n) memory use, and O(n(log(log n))) complexity.
    def self.up_to(max_prime) 
        Enumerator.new do |it| 
            # An array to mark numbers as NOT prime.
            # Since we'll use 1-based indexing for marking, need +1:
            marked = Array.new(max_prime + 1, false)

            # TODO: optimization, step by 2:
            for current in 2..max_prime
                if (marked[current]) # (not prime)
                    next
                end

                it.yield current

                # We can start filtering at current^2, because any other non-prime numbers before that will
                # have a prime factorization that includes a prime < this_num.
                # i.e.: the other filters already cover us up to that point.
                # TODO: Optimization, only iterate up to sqrt(max_prime), then yield remaining primes.
                for non_prime in ((current ** 2)..max_prime).step(current)
                    marked[non_prime] = true
                end
            end # for
        end
        
    end

    ##
    # Returns an Unbounded/Infinite +Enumerator+ that yields prime numbers.
    # 
    # This conceptually uses the Sieve of Eratosthenes algorithm, but with these modifications:
    # 1. Since we don't know the maximum prime we want to calculate, we can't mark non-primes in a block of memory.
    #    Instead, we keep a list of "filters" which can "mark" numbers as we iterate to them.
    # 2. New primes add new filters to the list to check.
    #
    # However, the performance is quite bad. Probably due to cache misses and branch (mis)prediction.
    #
    # See: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
    #
    # TODO: Also, the Enumerator runs out of Stack space. Are arrays stored on the stack in Ruby!?
    def self.unbounded
        Enumerator.new do |it|
            # Start at the first prime:
            next_num = 2.step

            # Instead of "marking" an infinite number of integers as not-prime, we keep some Enumerators
            # here that act as that mark incrimentally.
            filters = []

            loop do
                this_num = next_num.next
                is_prime = true # assuming until we prove otherwise
                for f in filters
                    while f.peek < this_num
                        # We've already passed this filter's current number, bump it to its next:
                        f.next
                    end
                    if f.peek == this_num then
                        is_prime = false
                        break
                    end
                end

                if is_prime then
                    it.yield this_num

                    # We can start filtering at this_num^2, because any other non-prime numbers before that will
                    # have a prime factorization that includes a prime < this_num.
                    # i.e.: the other filters already cover us up to that point.
                    filters.push (this_num**2).step(by: this_num)
                end
            end 

        end # Enumerator
    end # def enumerator
end # module