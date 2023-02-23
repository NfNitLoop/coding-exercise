require_relative "./lib/prime_gen"
require_relative "./lib/table"

def main
    output_table(num_primes: parse_args(ARGV), out: $stdout)
end

def output_table(out:, num_primes:)
    # TODO:
    # PrimeGen::up_to(max_prime) gives all primes <= max_prime
    # But the prompt asks for N primes.
    # There's likely an algorithm to say that we can find `num_primes` primes before max_prime
    # But for now I'm just going to go with primes up to 10k which seems reasonable for terminal output.
    primes = PrimeGen::up_to(10_000).take(num_primes)

    table = Table::Formatter.new out
    table.puts_row [nil] + primes

    for row_start in primes 
        table.puts_row [row_start] + primes.map { |col_start| col_start * row_start }
    end
end

# TODO: I assume Ruby has something like optparse built in. For now, brute-force parsing 1 arg. :) 
def parse_args(args) 
    if args.size == 0
        puts <<~END
            usage: ruby main.rb $someNumber

            Prints a multiplication table of the first $someNumber prime numbers.
            $someNumber must be a positive integer.
        END
        return
    elsif args.size > 1
        puts "Expected 1 integer argument"
        exit(1)
    end

    num_primes = args[0].to_i
    if (num_primes < 1) 
        puts "$someNumber must be >= 1"
        exit(1)
    end

    return num_primes
end

if __FILE__ == $0 then
    main
end