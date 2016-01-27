require 'spec_helper'

describe NFE::Helper::RPSField do
    describe "#new" do
        context "with no parameters or not only two paremeters" do
            it "raises an ArgumentError" do
                expect{ NFE::Helper::RPSField.new }.to            raise_error ArgumentError
                expect{ NFE::Helper::RPSField.new String.new }.to raise_error ArgumentError
            end
        end

        context "with invalid parameter type class" do
            it "raises ParamClassError" do
                expect{ NFE::Helper::RPSField.new 10, String.new }.to raise_error NFE::Errors::ParamClassError, /Parameter name must be String or Symbol/
                expect{ NFE::Helper::RPSField.new String.new, 10 }.to raise_error NFE::Errors::ParamClassError, /Parameter value must be String/
            end
        end

        context "with valid parameters" do
            it "returns a NFE::Helper::RPSField object" do
                expect(NFE::Helper::RPSField.new String.new, String.new).to be_an NFE::Helper::RPSField
            end
        end
    end

    describe "#valid?" do
        it "returns true if the RPSField is a valid RPS field"
        it "returns false if the RPSField is not a valid RPS field"
    end
end
