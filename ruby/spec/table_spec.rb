require_relative '../lib/table'

describe Table do
    context 'when using a Table::Formatter' do
        sample_data = [
            [nil, "foo", "bar"],
            ["baz", 42, false]
        ]

        it 'should output the correct format' do
            out = ""
            table = Table::Formatter.new out
            sample_data.each { |row| table.puts_row row }

            expect(out).to eq <<~END
                | | foo | bar |
                | baz | 42 | false |
            END
        end

        it 'should respect sep and pad options' do
            out = ""
            table = Table::Formatter.new(out, pad: "", sep: "!")
            sample_data.each { |row| table.puts_row row }

            expect(out).to eq <<~END
                !!foo!bar!
                !baz!42!false!
            END
        end
    end
end
