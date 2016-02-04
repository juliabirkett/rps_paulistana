module NFE
    class HeaderField < RPSField
        VALID_NAMES = [
            :layout_version,
            :municipal_registration,
            :start_date,
            :end_date
        ]

        def initialize name, value
            super
            raise Errors::NonExistentFieldError, /Register: #{self.class}; Name: #{@name}; Value: #{@value}/    if !self.class::VALID_NAMES.include?(@name.to_sym)
        end
    end
end
