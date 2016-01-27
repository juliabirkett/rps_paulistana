module NFE
    class Register
        VALID_TYPES     = [1, 2, 3, 5, 9]
        REQUIRED_FIELDS = []

        def validate!
            if !@type.is_a? String and !@type.is_a? Integer
                raise Errors::ParamClassError,      /Parameter type must be String or Integer/
            end

            if !VALID_TYPES.include?(@type.to_i)
                raise Errors::RPSRegisterTypeError, /Invalid RPS Register type/
            end
        end

        def initialize type
            @type = type
            validate!
        end

        def valid?
            return (REQUIRED_FIELDS - @fields.keys).empty?
        end
    end
end
