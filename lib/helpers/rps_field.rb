module NFE
    module Helper
        class RPSField
            attr_reader :name
            attr_reader :value

            def validate!
                raise Errors::ParamClassError, /Parameter name must be String or Symbol/   if !@name.is_a?  String and !@name.is_a? Symbol
                raise Errors::ParamClassError, /Parameter value must be String/            if !@value.is_a? String
            end

            def initialize name, value
                @name  = name
                @value = value
                validate!
            end

            def valid?
                case @name.to_sym
                when :layout_version
                    self.numeric? and self.length == 3
                when :municipal_registration, :date, :taker_ccm, :zip_code
                    self.numeric? and self.length == 8
                when :rps_type
                    self.alphanumeric? and self.length == 5
                when :rps_number
                    self.numeric? and self.length == 12
                when :rps_status
                    self.alphanumeric? and self.length == 1
                when :service_code
                    self.numeric? and self.length == 5
                when :amount
                    self.numeric? and self.length == 15
                when :aliquot
                    self.numeric? and self.length == 4
                when :iss_by, :taker_type
                    self.numeric? and self.length == 1
                when :taker_document
                    self.numeric? and self.length == 14
                when :taker_name, :taker_email
                    self.alphanumeric? and self.length == 75
                when :address_type
                    self.alphanumeric? and self.length == 3
                when :address, :city
                    self.alphanumeric? and self.length == 50
                when :address_number
                    self.alphanumeric? and self.length == 10
                when :complement, :district
                    self.alphanumeric? and self.length == 30
                when :uf
                    self.alphanumeric? and self.length == 2
                when :total_detail_lines
                    self.numeric? and self.length == 7
                end
            end

            def alphanumeric?
                return @value.match(/^[[:alnum:]]+$/) != nil
            end

            def numeric?
                return @value.match(/^[0-9]+$/) != nil
            end

            def length
                return @value.length
            end
        end
    end
end
