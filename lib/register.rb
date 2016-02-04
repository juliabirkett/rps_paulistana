module NFE
    class Register
        VALID_TYPES     = [1, 6, 9]
        REQUIRED_FIELDS = []
        DEFAULTS  = {}

        attr_reader :fields

        def validate!
            if !@type.is_a? String and !@type.is_a? Integer
                raise Errors::InvalidParamError,      /Parameter type must be String or Integer/
            end

            if !VALID_TYPES.include?(@type.to_i)
                raise Errors::RPSRegisterTypeError, /Invalid RPS Register type/
            end
        end

        def initialize type
            @type = type
            @fields = Hash.new
            validate!
        end

        def valid?
            return (self.class::REQUIRED_FIELDS - @fields.keys).empty?
        end

        def << fields
            raise Errors::InvalidParamError, /Expecting Hash parameter/ if !fields.is_a? Hash
            fields = self.class::DEFAULTS.merge(fields)
            fields.each do |name, value|
                field = Object.const_get("#{self.class}Field").new name, value

                if field.valid?
                    field.check_value
                    @fields[name] = value
                else
                    raise Errors::InvalidFieldError, /The field #{name}; Value: #{value} is invalid. Check its value/
                end
            end

            return @fields
        end
    end
end
