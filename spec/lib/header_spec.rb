require 'spec_helper'

describe NFE::Header do
    describe "#new" do
        it "Receives type and returns Register object" do
            expect(NFE::Register.new "1").to not_raise_error
        end
    end
end
