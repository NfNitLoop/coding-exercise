module Table
    ##
    # Can output a "table" ()
    class Formatter
        ##
        # `out` is something that can have strings appended to it with <<. 
        # (ex: `$stdout` or a (non-frozen) string)
        #
        # `sep` - The separator between (and outside of) columns.
        #
        # `pad` padding between the separator and the contents of the column.
        def initialize(out, sep: "|", pad: " ")
            @out = out
            @sep = sep
            @pad = pad
        end

        ##
        # Append a row of your table to `out`.
        #
        # `row` is an Array of values.
        # 
        # It is up to you to make sure all rows of your table have the same number of columns.
        # A `nil` will output an empty column.
        # All other values will be output as `value.to_s`
        #
        # If your input values have newlines or the `sep` character, you'll get invalid table output.
        def puts_row(row)
            if row.size < 1
                raise Exception.new "Rows must have at least one value."
            end

            @out << @sep
            for col in row
                if !col.nil?
                    @out << @pad << col.to_s 
                end
                @out << @pad << @sep
            end
            @out << "\n"
        end
    end
end