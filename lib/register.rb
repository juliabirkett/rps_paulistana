module NFE
    class Register
        VALID_TYPES     = [1, 6, 9]
        REQUIRED_FIELDS = []
        VALID_FIELDS    = []
        DEFAULTS  = {}

        attr_reader :fields
        attr_reader :type

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

        def valid_register_field? name
            return (self.class::VALID_FIELDS).include?(name)
        end

        def << fields
            raise Errors::InvalidParamError, /Expecting Hash parameter/ if !fields.is_a? Hash
            fields = self.class::DEFAULTS.merge(fields)
            fields.each do |name, value|
                if valid_register_field?(name)
                    field = RPSField.new name, value

                    if field.valid?
                        field.check_value
                        @fields[name] = value
                    else
                        raise Errors::InvalidFieldError, /The field #{name}; Value: #{value} is invalid. Check its value/
                    end
                else
                    raise Errors::NonExistentFieldError, /Register: #{self.class}; Name: #{name}; Value: #{value}/
                end

            end

            return @fields
        end

        def to_s
            string = @type.to_s
            self.class::VALID_FIELDS.each do |field_name|
                string += @fields[field_name]
            end

            string
        end
    end
end
