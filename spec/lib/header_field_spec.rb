require 'spec_helper'

describe NFE::HeaderField do
    describe "#new" do
        context "with no parameters or not only two paremeters" do
            it "raises an ArgumentError" do
                expect{ NFE::HeaderField.new }           .to raise_error ArgumentError
                expect{ NFE::HeaderField.new String.new }.to raise_error ArgumentError
            end
        end

        context "with invalid parameter type class" do
            it "raises InvalidParamError" do
                expect{ NFE::HeaderField.new 10, String.new }.to raise_error NFE::Errors::InvalidParamError, /Parameter name must be String or Symbol/
                expect{ NFE::HeaderField.new String.new, 10 }.to raise_error NFE::Errors::InvalidParamError, /Parameter value must be String/
            end
        end

        context "with empty String parameters" do
            it "raises an InvalidParamError" do
                expect{ NFE::HeaderField.new "", "" }        .to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::HeaderField.new String.new, "" }.to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::HeaderField.new "", String.new }.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameters" do
            context "with valid field name" do
                it "returns a NFE::HeaderField object" do
                    expect(NFE::HeaderField.new "layout_version", "value")        .to be_an NFE::HeaderField
                    expect(NFE::HeaderField.new :layout_version, "value")         .to be_an NFE::HeaderField
                    expect(NFE::HeaderField.new "municipal_registration", "value").to be_an NFE::HeaderField
                    expect(NFE::HeaderField.new :municipal_registration, "value") .to be_an NFE::HeaderField
                    expect(NFE::HeaderField.new "start_date", "value")            .to be_an NFE::HeaderField
                    expect(NFE::HeaderField.new :start_date, "value")             .to be_an NFE::HeaderField
                    expect(NFE::HeaderField.new "end_date", "value")              .to be_an NFE::HeaderField
                    expect(NFE::HeaderField.new :end_date, "value")               .to be_an NFE::HeaderField
                end
            end

            context "with invalid field name" do
                it "raises a NonExistentFieldError" do
                    expect{NFE::HeaderField.new "field", "value"}.to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::HeaderField.new :field, "value"} .to raise_error NFE::Errors::NonExistentFieldError
                end
            end
        end
    end

    describe "#check_value" do
        context "with invalid field value" do
            it "raises an Error" do
                expect{ (NFE::HeaderField.new :layout_version, "100").check_value } .to raise_error NFE::Errors::LayoutVersionError
                expect{ (NFE::HeaderField.new :start_date, "20162908").check_value }.to raise_error ArgumentError, /invalid date/
                expect{ (NFE::HeaderField.new :end_date, "20162908").check_value }  .to raise_error ArgumentError, /invalid date/
            end
        end

        context "with valid field value" do
            it "do not raise Error" do
                expect{ (NFE::HeaderField.new :layout_version, "001").check_value } .to_not raise_error
                expect{ (NFE::HeaderField.new :start_date, "20160108").check_value }.to_not raise_error
                expect{ (NFE::HeaderField.new :end_date, "20160108").check_value }  .to_not raise_error
            end
        end
    end

    describe "#valid?" do
        context "with valid field name" do
            it "returns whether a HeaderField value is valid" do
                expect((NFE::HeaderField.new :layout_version, "002").valid?)                   .to be true
                expect((NFE::HeaderField.new :municipal_registration, "48815446").valid?)      .to be true
                expect((NFE::HeaderField.new :start_date, "20160101").valid?)                  .to be true
                expect((NFE::HeaderField.new :end_date, "20160101").valid?)                    .to be true

                expect((NFE::HeaderField.new :layout_version, "0s02").valid?)                  .to be false
                expect((NFE::HeaderField.new :municipal_registration, "4881aaa5446").valid?)   .to be false
                expect((NFE::HeaderField.new :start_date, "201601012").valid?)                 .to be false
                expect((NFE::HeaderField.new :end_date, "201601012").valid?)                   .to be false
            end
        end
    end
end
