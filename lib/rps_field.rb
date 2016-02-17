module NFE
    class RPSField
        attr_reader :name, :value, :type, :size, :auto_fill

        module Type
            ALPHA = "ALPHA"
            NUM   = "NUM"
            EMAIL = "EMAIL"
        end

        def validate!
            raise Errors::InvalidParamError, /Parameter name must be String or Symbol/  if !@name .is_a? String and !@name.is_a? Symbol
            raise Errors::InvalidParamError, /Parameter value must be String/           if !@value.is_a? String
            raise Errors::InvalidParamError                                             if  @name.empty?
        end

        def initialize name, value = " "
            @name      = name
            @value     = value
            @auto_fill = true
            validate!
            @name = @name.to_sym
            @value.upcase!
            set_configs
        end

        def set_configs
            case @name
            when :taker_email
                @size = 75
                @type = Type::EMAIL
            when :aliquot
                @size = 4
                @type = Type::NUM
            when :total_detail_lines
                @size = 7
                @type = Type::NUM
            when :taker_document
                @size = 14
                @type = Type::NUM
            when :amount, :tax_amount, :total_amount, :total_tax_amount, :pis_pasep, :cofins, :inss, :ir, :cssl
                @size = 15
                @type = Type::NUM
            when :rps_number, :matriculation
                @size = 12
                @type = Type::NUM
            when :taker_ccm
                @size = 8
                @type = Type::NUM
            when :private_blank_field
                @size = 200
                @type = Type::ALPHA
            when :taker_name
                @size = 75
                @type = Type::ALPHA
            when :address_type
                @size = 3
                @type = Type::ALPHA
            when :address, :city
                @size = 50
                @type = Type::ALPHA
            when :address_number, :tributary_source
                @size = 10
                @type = Type::ALPHA
            when :complement, :district
                @size = 30
                @type = Type::ALPHA
            when :service_description
                @size = @value.length
                @type = Type::ALPHA
            when :rps_type, :rps_serial
                @size = 5
                @type = Type::ALPHA
            when :layout_version
                @size = 3
                @type = Type::NUM
                @auto_fill = false
            when :start_date, :end_date, :issuing_date, :municipal_registration
                @size = 8
                @type = Type::NUM
                @auto_fill = false
            when :zip_code
                @size = 8
                @type = Type::NUM
            when :state_registration, :cei
                @size = 12
                @type = Type::NUM
            when :service_code
                @size = 5
                @type = Type::NUM
                @auto_fill = false
            when :tributary_percentage
                @size = 5
                @type = Type::NUM
            when :iss_by, :taker_type
                @size = 1
                @type = Type::NUM
                @auto_fill = false
            when :city_ibge_code
                @size = 7
                @type = Type::NUM
            when :rps_status
                @size = 1
                @type = Type::ALPHA
                @auto_fill = false
            when :uf
                @size = 2
                @type = Type::ALPHA
            end
        end

        def default_char
            case @type
                when Type::NUM
                    return "0"
                else
                    return " "
            end
        end

        def valid?
            if @type.eql? Type::ALPHA
                valid = self.alphanumeric?
            elsif @type.eql? Type::EMAIL
                valid = self.email?
            elsif @type.eql? Type::NUM
                valid = self.numeric?
            end

            self.fill! if @auto_fill == true
            return (valid and self.length == @size)
        end

        def check_value
            case @name
            when :layout_version
                if !["001", "002"].include? @value
                    raise Errors::LayoutVersionError, /Only 001 and 002 versions supported/
                end
            when :rps_type
                if !@value.strip.eql?("RPS") and !@value.strip.eql?("RPS-M")
                    raise Errors::RPSTypeError, /RPS types allowed: RPS and RPS-M/
                end
            when :rps_status
                if !["T", "F", "A", "B", "M", "N", "X", "V", "P", "C"].include? @value
                    raise Errors::RPSStatusError, /Invalid RPS situation\/status. Please, check the manual (section 4.3.6)/
                end
            when :iss_by
                if !["1", "2", "3"].include? @value
                    raise Errors::ISSByError, /Invalid ISS. Please, check the manual (section 4.3.11)/
                end
            when :taker_type
                if !["1", "2", "3"].include? @value
                    raise Errors::TakerTypeError, /Invalid Taker type. Please, check the manual (section 4.3.12)/
                end
            when :start_date, :end_date, :issuing_date
                Date.strptime(@value, "%Y%m%d")
            end
        end

        def alphanumeric?
            return @value.match(/^[[:alnum:]\s]+$/) != nil
        end

        def numeric?
            return (@value.match(/^[0-9]+$/) != nil or @value.eql? " ")
        end

        def email?
            return (@value.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) != nil or @value.eql? " ")
        end

        def length
            return @value.length
        end

        def fill!
            while self.length < @size do
                if self.default_char.eql? "0"
                    @value = self.default_char + @value
                else
                    @value << self.default_char
                end
            end
        end
    end
end
