module NFE
    class Register
        VALID_TYPES = [1, 2, 3, 5, 9]

        def initialize type
            raise ValidationError if !VALID_TYPES.include?(type.to_i) 
            @type = type
        end
    end

    class ValidationError < StandardError; end
end
