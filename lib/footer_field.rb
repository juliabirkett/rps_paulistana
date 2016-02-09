module NFE
    class FooterField < RPSField
        VALID_NAMES = [
            :total_detail_lines,
            :total_amount,
            :total_tax_amount,
        ]
    end
end
