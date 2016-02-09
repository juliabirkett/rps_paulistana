module NFE
    class HeaderField < RPSField
        VALID_NAMES = [
            :layout_version,
            :municipal_registration,
            :start_date,
            :end_date
        ]
    end
end
