module NFE
    class RPS
        attr_reader :header, :details, :footer

        def initialize
            @header  = Header.new
            @footer  = Footer.new
            @details = Array.new
        end

        def add_header fields
            @header << fields
        end

        def add_detail fields
            detail = Detail.new
            detail << fields
            @details << detail  if detail.valid?
        end

        def set_footer
            total_amount     = 0
            total_tax_amount = 0
            @details.each do |detail|
                total_amount     += detail.to_hash[:amount].to_i
                total_tax_amount += detail.to_hash[:tax_amount].to_i
            end

            @footer << {total_detail_lines: @details.count.to_s, total_amount: total_amount.to_s, total_tax_amount: total_tax_amount.to_s}
        end

        def to_s
            puts @header.to_s
            @details.each do |detail|
                puts detail.to_s
            end
            puts @footer.to_s
        end

        def save_to_file
        end
    end
end
