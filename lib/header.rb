module NFE
    class Header < Register
        REQUIRED_FIELDS = [:layout_version, :municipal_registration, :start_date, :end_date]
        DEFAULTS = {
            layout_version: "002",
            start_date: Time.now.to_date.strftime("%Y%m%d"),
            end_date:   Time.now.to_date.strftime("%Y%m%d")
        }

        def initialize
            super 1
        end
    end
end
