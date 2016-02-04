module NFE
    class Footer < Register
        REQUIRED_FIELDS = [
            :total_detail_lines,
            :total_amount,
            :total_tax_amount
        ]

        DEFAULTS = {
            total_detail_lines: "0"
        }

        def initialize
            super 9
        end
    end
end
