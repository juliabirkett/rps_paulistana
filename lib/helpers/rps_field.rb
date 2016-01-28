module NFE
    module Helper
        class RPSField
            attr_reader :name
            attr_reader :value

            def validate!
                raise Errors::ParamClassError, /Parameter name must be String or Symbol/   if !@name.is_a?  String and !@name.is_a? Symbol
                raise Errors::ParamClassError, /Parameter value must be String/            if !@value.is_a? String
                raise Errors::InvalidParamError                                            if  @name.empty? or @value.empty?
            end

            def initialize name, value
                @name  = name
                @value = value
                validate!
                @value.upcase!
            end

            def valid?
                case @name.to_sym
                when :taker_email
                    self.fill_with! " ", 75
                when :taker_document
                    self.fill_with! "0", 14 and self.numeric?
                when :taker_name
                    self.fill_with! " ", 75 and self.alphanumeric?
                when :address_type
                    self.fill_with! " ", 3 and self.alphanumeric?
                when :address, :city
                    self.fill_with! " ", 50 and self.alphanumeric?
                when :address_number, :tributary_source
                    self.fill_with! " ", 10 and self.alphanumeric?
                when :complement, :district
                    self.fill_with! " ", 30 and self.alphanumeric?
                when :rps_type, :rps_serial
                    self.fill_with! " ", 5 and self.alphanumeric?
                when :layout_version
                    self.numeric? and self.length == 3
                when :municipal_registration, :date, :taker_ccm, :zip_code
                    self.numeric? and self.length == 8
                when :rps_number, :cei
                    self.numeric? and self.length == 12
                when :service_code, :tributary_percentage
                    self.numeric? and self.length == 5
                when :amount
                    self.numeric? and self.length == 15
                when :aliquot
                    self.numeric? and self.length == 4
                when :iss_by, :taker_type
                    self.numeric? and self.length == 1
                when :total_detail_lines, :city_ibge_code
                    self.numeric? and self.length == 7
                when :rps_status
                    self.alphanumeric? and self.length == 1
                when :uf
                    self.alphanumeric? and self.length == 2
                when :service_description
                    self.alphanumeric?
                end
            end

            def alphanumeric?
                return @value.match(/^[[:alnum:]\s]+$/) != nil
            end

            def numeric?
                return @value.match(/^[0-9]+$/) != nil
            end

            def length
                return @value.length
            end

            def fill_with! char, size
                while self.length < size do
                    @value << char
                end

                return self.length == size
            end
        end
    end
end
