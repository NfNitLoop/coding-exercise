require_relative '../lib/prime_gen'

describe PrimeGen do
    gen = PrimeGen::Generator.new()

    context 'when generating primes' do
        it 'should generate the 2 as the first prime' do
            expect(1).to eq false # TODO
        end
    end
end