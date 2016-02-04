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
            @details << (Detail.new << fields)
        end

        def add_footer fields
            @footer << fields
        end

        def string
        end

        def save_to_file
        end
    end
end
