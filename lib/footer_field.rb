module NFE
    class FooterField < RPSField
        VALID_NAMES = [
            :total_detail_lines,
            :total_amount,
            :total_tax_amount,
        ]

        def initialize name, value
            super
            raise Errors::NonExistentFieldError, /Register: #{self.class}; Name: #{@name}; Value: #{@value}/         if !self.class::VALID_NAMES.include?(@name.to_sym)
        end
    end
end
