require_relative '../lib/prime_gen'

describe PrimeGen do
    primes = PrimeGen::up_to(10_000_000)

    context 'when generating primes' do
        it 'should have correct first 10 primes' do
            # Surprise! .take seems to call .rewind. See README.
            expect(primes.take(10)).to eq [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        end

        it 'performs much better than the unbounded generator' do
            primes.rewind()
            elapsed_secs = time { primes.lazy.drop(99_999).next}
            expect(elapsed_secs).to be < 5
            puts "elapsed_secs: #{elapsed_secs}"
        end

    end
end

describe 'Unbounded generator' do
    primes = PrimeGen::unbounded()

    context 'when generating primes' do
        it 'should have correct first 10 primes' do
            expect(primes.take(10)).to eq [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        end

        it 'performs poorly, unfortunately' do
            primes.rewind

            prime = 0
            elapsed_secs = time { primes.lazy.drop(9_999).next }

            expect(elapsed_secs).to be > 1 # 😢
        end
    end
end


# TODO: https://jetrockets.com/blog/assert-performance-with-rspec-benchmark
# But I'm trying not to use non-standard gems, so I'll write a little timer:
def time
    start = Time.now.to_f
    yield
    return Time.now.to_f - start
end