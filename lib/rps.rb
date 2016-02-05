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
            return @header.valid?
        end

        def add_detail fields
            detail = Detail.new << fields
            @details << detail
            return detail.valid?
        end

        def add_footer fields
            @footer << fields
            return @footer.valid?
        end

        def string
        end

        def save_to_file
        end
    end
end
