require 'spec_helper'

describe NFE::FooterField do
    describe "#new" do
        context "with no parameters or not only two paremeters" do
            it "raises an ArgumentError" do
                expect{ NFE::FooterField.new }           .to raise_error ArgumentError
                expect{ NFE::FooterField.new String.new }.to raise_error ArgumentError
            end
        end

        context "with invalid parameter type class" do
            it "raises InvalidParamError" do
                expect{ NFE::FooterField.new 10, String.new }.to raise_error NFE::Errors::InvalidParamError, /Parameter name must be String or Symbol/
                expect{ NFE::FooterField.new String.new, 10 }.to raise_error NFE::Errors::InvalidParamError, /Parameter value must be String/
            end
        end

        context "with empty String parameters" do
            it "raises an InvalidParamError" do
                expect{ NFE::FooterField.new "", "" }        .to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::FooterField.new String.new, "" }.to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::FooterField.new "", String.new }.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameters" do
            context "with valid field name" do
                it "returns a NFE::FooterField object" do
                    expect(NFE::FooterField.new "total_detail_lines", "value").to be_an NFE::FooterField
                    expect(NFE::FooterField.new :total_detail_lines, "value") .to be_an NFE::FooterField
                    expect(NFE::FooterField.new "total_amount", "value")      .to be_an NFE::FooterField
                    expect(NFE::FooterField.new :total_amount, "value")       .to be_an NFE::FooterField
                    expect(NFE::FooterField.new "total_tax_amount", "value")  .to be_an NFE::FooterField
                    expect(NFE::FooterField.new :total_tax_amount, "value")   .to be_an NFE::FooterField
                end
            end

            context "with invalid field name" do
                it "raises a NonExistentFieldError" do
                    expect{NFE::FooterField.new "field", "value"}         .to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::FooterField.new :field, "value"}          .to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::FooterField.new "layout_version", "value"}.to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::FooterField.new :layout_version, "value"} .to raise_error NFE::Errors::NonExistentFieldError
                end
            end
        end
    end

    describe "#valid?" do
        context "with valid field name" do
            it "returns whether a FooterField value is valid" do
                expect((NFE::FooterField.new :total_detail_lines, "1").valid?)       .to be true
                expect((NFE::FooterField.new :total_amount, "500").valid?)           .to be true
                expect((NFE::FooterField.new :total_tax_amount, "5").valid?)         .to be true

                expect((NFE::FooterField.new :total_detail_lines, "156189481").valid?).to be false
                expect((NFE::FooterField.new :total_amount, "teste").valid?)          .to be false
                expect((NFE::FooterField.new :total_tax_amount, "teste").valid?)      .to be false
            end
        end
    end
end
