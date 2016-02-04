require 'spec_helper'

describe NFE::RPS do
    describe "#new" do
        context "passing parameters" do
            it "raises an ArgumentError" do
                expect{NFE::RPS.new "teste"}.to raise_error ArgumentError
            end
        end

        it "instantiate an Header, an Footer and an Array (which will be populated with Details objects)" do
            expect((NFE::RPS.new).header) .to be_an NFE::Header
            expect((NFE::RPS.new).details).to be_an Array
            expect((NFE::RPS.new).footer) .to be_an NFE::Footer
        end
    end

    describe "#add_header" do
        context "with invalid parameter" do
            it "raise InvalidParamError" do
                expect{(NFE::RPS.new).add_header "teste"}.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameter" do
            it "returns a populated Hash" do
                expect((NFE::RPS.new).add_header({layout_version: "003"}))
            end
        end
    end
end
