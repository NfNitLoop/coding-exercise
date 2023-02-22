require_relative '../lib/prime_gen'

describe PrimeGen do
    gen = PrimeGen::enumerator

    context 'when generating primes' do
        it 'should generate the 2 as the first prime' do
            expect(gen.next).to eq 2
        end

        it 'should have expected first 10 primes' do
            # Surprise! .take seems to call .rewind. See README.
            expect(gen.take(10)).to eq [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        end

        # TODO: 
        # 1. https://jetrockets.com/blog/assert-performance-with-rspec-benchmark
        # 2. Bleh, this is slow! Is it the algorithm? Ruby overhead?
        # 3. FiberError: can't alloc machine stack to fiber (1 x 659456 bytes): No error
        #    Why is it using the stack? Do I need to implement my own class to avoid fibers?
        it 'should perform reasonably well' do
            prime = gen.lazy.drop(99_999).next

            puts "Got prime #{prime}"
        end
    end
end