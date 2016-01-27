require 'spec_helper'

describe NFE::Register do
    describe "#new" do
        context "with no parameters or more than one parameter" do
            it "raises an ArgumentError" do
                expect{ NFE::Register.new }.to                   raise_error ArgumentError
                expect{ NFE::Register.new "first", "second" }.to raise_error ArgumentError
            end
        end

        context "with an invalid register type" do
            it "raises ValidationError" do
                expect{ NFE::Register.new "99" }.to raise_error NFE::ValidationError
            end
        end

        context "with a valid register type" do
            it "return NFE::Register object" do
                expect(NFE::Register.new "1").to be_an_instance_of NFE::Register
            end
        end
    end
end
