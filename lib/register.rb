module NFE
    class Register
        VALID_TYPES     = [1, 6, 9]
        REQUIRED_FIELDS = []
        VALID_FIELDS    = []
        DEFAULTS  = {}

        attr_reader   :fields, :type, :required_fields

        def validate!
            if !@type.is_a? String and !@type.is_a? Integer
                raise Errors::InvalidParamError,      /Parameter type must be String or Integer/
            end

            if !VALID_TYPES.include?(@type.to_i)
                raise Errors::RPSRegisterTypeError, /Invalid RPS Register type/
            end
        end

        def initialize type
            @type            = type
            @fields          = Array.new
            @required_fields = Array.new(self.class::REQUIRED_FIELDS)
            validate!
        end

        def valid?
            set_non_filled
            return (@required_fields - self.to_hash.keys).empty?
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
                        @fields << field
                    else
                        raise Errors::InvalidFieldError, /The field #{field.name}; Value: #{field.value} is invalid. Check its value/
                    end
                else
                    raise Errors::NonExistentFieldError, /Register: #{self.class}; Name: #{name}; Value: #{value}/
                end
            end

            return @fields
        end

        private def set_non_filled
            non_filled = (self.class::VALID_FIELDS - @required_fields) - self.to_hash.keys

            non_filled.each do |field_name|
                field = RPSField.new field_name
                if field.valid?
                    field.check_value
                    @fields << field
                else
                    raise Errors::InvalidFieldError, /The field #{field.name}; Value: #{field.value} is invalid. Check its value/
                end
            end
        end

        def to_hash
            fields_hash = Hash.new
            @fields.each do |field|
                fields_hash[field.name] = field.value
            end

            return fields_hash
        end

        def to_s
            raise Errors::InvalidRegisterError, /The register could not be converted to String because it is not valid/     if !self.valid?
            string = @type.to_s
            self.class::VALID_FIELDS.each do |field_name|
                string += self.to_hash[field_name]
            end

            return "#{string}\n"
        end
    end
end
