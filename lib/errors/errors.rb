module NFE
    module Errors
        class ParamClassError      < StandardError; end
        class RPSRegisterTypeError < StandardError; end
        class InvalidParamError    < StandardError; end
        class LayoutVersionError   < StandardError; end
        class RPSTypeError         < StandardError; end
        class RPSStatusError       < StandardError; end
        class ISSByError           < StandardError; end
        class TakerTypeError       < StandardError; end
    end
end
