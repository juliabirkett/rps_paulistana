module NFE
    class Header < Register
        REQUIRED_FIELDS = [:layout_version, :municipal_registration, :date]

        def initialize
            super 1
        end

    end
end
