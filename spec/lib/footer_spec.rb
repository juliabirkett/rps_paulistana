require 'spec_helper'

describe NFE::Footer do
    describe "#new" do
        context "passing parameter(s)" do
            it "raises an ArgumentError" do
                expect{NFE::Footer.new "teste"}.to raise_error ArgumentError
            end
        end

        it "returns an NFE::Footer object" do
            expect(NFE::Footer.new).to be_an NFE::Footer
        end
    end

    describe "#<<" do
        context "with invalid parameter" do
            it "raises an InvalidParamError" do
                expect{NFE::Footer::new << "teste"}.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameter" do
            context "with nonexistent field" do
                it "raises an NonExistentFieldError" do
                    expect{NFE::Footer::new << {teste: "idk", nonexistent: "aa"}}         .to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::Footer::new << {layout_version: "idk", nonexistent: "aa"}}.to raise_error NFE::Errors::NonExistentFieldError
                end
            end

            context "with invalid field" do
                it "raises an InvalidFieldError" do
                    expect{(NFE::Footer::new << {total_detail_lines: "as"})}.to raise_error NFE::Errors::InvalidFieldError
                end
            end

            context "with valid fields" do
                it "returns a populated Hash of field name/value" do
                    expect((NFE::Footer::new << {total_detail_lines: "1"}).empty?)                                              .to be false
                    expect((NFE::Footer::new << {total_amount: "001"}).empty?)                                                  .to be false
                    expect((NFE::Footer::new << {total_tax_amount: "002"}).empty?)                                              .to be false
                    expect((NFE::Footer::new << {total_detail_lines: "1", total_amount: "001", total_tax_amount: "002"}).empty?).to be false
                end
            end
        end
    end

    describe "#valid?" do
        it "return whether the register is valid (contains required fields)" do
            footer = NFE::Footer.new
            expect(footer.valid?).to be false
            footer << {total_amount: "200"}
            expect(footer.valid?).to be false
            footer << {total_detail_lines: "123"}
            expect(footer.valid?).to be false
            footer << {total_tax_amount: "02"}
            expect(footer.valid?).to be true
            footer << {total_amount: "200", total_detail_lines: "123", total_tax_amount: "02"}
            expect(footer.valid?).to be true
        end
    end

    describe "#to_s" do
        context "with valid Footer" do
            it "returns a String" do
                footer = NFE::Footer.new
                footer << {total_amount: "0", total_tax_amount: "9"}
                expect(footer.to_s).to be_an String
            end
        end

        context "with invalid Footer" do
            it "raises InvalidRegisterError" do
                footer = NFE::Footer.new
                footer << {total_detail_lines: "1"}
                expect{footer.to_s}.to raise_error NFE::Errors::InvalidRegisterError
            end
        end
    end
end
