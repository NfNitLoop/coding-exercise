module PrimeGen

    ##
    # Returns an +Enumerator+ that yields subsequent prime numbers.
    #
    # See: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
    def self.enumerator
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