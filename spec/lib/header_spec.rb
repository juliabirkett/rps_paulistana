require 'spec_helper'

describe NFE::Header do
    describe "#new" do
        context "passing parameter(s)" do
            it "raises an ArgumentError" do
                expect{ NFE::Header.new "teste" }.to raise_error ArgumentError
            end
        end

        it "returns an NFE::Header object" do
            expect(NFE::Header.new).to be_an NFE::Header
        end
    end
    # describe "#valid?" do
    #     it "return false if the register does not contain required fields" do
    #         expect((NFE::Header.new).valid?).to be false
    #     end
    #     it "return true if the register contains required fields"
    # end
end
