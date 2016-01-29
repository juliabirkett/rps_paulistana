module NFE
    class Header < Register
        attr_reader :fields

        REQUIRED_FIELDS = []

        def initialize fields
            super 1
        end
    end
end
