module NFE
    module Errors
        class RPSRegisterTypeError < StandardError; end
        class InvalidParamError    < StandardError; end
        class LayoutVersionError   < StandardError; end
        class RPSTypeError         < StandardError; end
        class RPSStatusError       < StandardError; end
        class ISSByError           < StandardError; end
        class TakerTypeError       < StandardError; end
        class NonExistentFieldError< StandardError; end
        class InvalidFieldError    < StandardError; end
        class InvalidRegisterError < StandardError; end
    end
end
