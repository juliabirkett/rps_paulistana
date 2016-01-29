require 'spec_helper'

describe NFE::Register do
    describe "#new" do
        context "with no parameters or more than one parameter" do
            it "raises an ArgumentError" do
                expect{ NFE::Register.new }                       .to raise_error ArgumentError
                expect{ NFE::Register.new String.new, String.new }.to raise_error ArgumentError
            end
        end

        context "with an invalid RPS Register Type" do
            it "raises RPSRegisterTypeError" do
                expect{ NFE::Register.new "99" }.to raise_error NFE::Errors::RPSRegisterTypeError, /Invalid RPS Register type/
            end
        end

        context "with an invalid parameter type class" do
            it "raises ParamClassError" do
                expect{ NFE::Register.new :param }.to raise_error NFE::Errors::ParamClassError, /Parameter type must be String or Integer/
            end
        end

        context "with a valid RPS Register type" do
            it "returns a NFE::Register object" do
                expect(NFE::Register.new "1").to be_an NFE::Register
            end
        end
    end
end
