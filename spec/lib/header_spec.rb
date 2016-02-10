require 'spec_helper'

describe NFE::Header do
    describe "#new" do
        context "passing parameter(s)" do
            it "raises an ArgumentError" do
                expect{NFE::Header.new "teste"}.to raise_error ArgumentError
            end
        end

        it "returns an NFE::Header object" do
            expect(NFE::Header.new).to be_an NFE::Header
        end
    end

    describe "#<<" do
        context "with invalid parameter" do
            it "raises an InvalidParamError" do
                expect{NFE::Header::new << "teste"}.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameter" do
            context "with nonexistent field" do
                it "raises an NonExistentFieldError" do
                    expect{NFE::Header::new << {teste: "idk", nonexistent: "aa"}}.to raise_error NFE::Errors::NonExistentFieldError
                end
            end

            context "with invalid field" do
                it "raises an InvalidFieldError" do
                    expect{(NFE::Header::new << {layout_version: "01", municipal_registration: "48815446"})}.to raise_error NFE::Errors::InvalidFieldError
                end
            end

            context "with invalid field value (when the field has values restrictions)" do
                context "when :layout_version" do
                    it "raises LayoutVersionError" do
                        expect{(NFE::Header::new << {layout_version: "003"})}.to raise_error NFE::Errors::LayoutVersionError
                        expect{(NFE::Header::new << {start_date: "20162908", end_date: "20162908"})}.to raise_error ArgumentError, /invalid date/
                    end
                end
            end

            context "with valid fields" do
                it "returns a populated Hash of field name/value" do
                    expect((NFE::Header::new << {municipal_registration: "48815446", start_date: "20160506"}).empty?).to be false
                    expect((NFE::Header::new << {layout_version: "001", municipal_registration: "48815446"}).empty?) .to be false
                    expect((NFE::Header::new << {layout_version: "002", municipal_registration: "00000002"}).empty?) .to be false
                end
            end
        end
    end

    describe "#valid?" do
        it "return whether the register is valid (contains required fields)" do
            header = NFE::Header.new
            expect(header.valid?).to be false
            header << {layout_version: "002", start_date: "20160201", end_date: "20160201"}
            expect(header.valid?).to be false
            header << {municipal_registration: "48815400"}
            expect(header.valid?).to be true
            header << {layout_version: "001", municipal_registration: "48815446", start_date: "20160201", end_date: "20160201"}
            expect(header.valid?).to be true
        end
    end

    describe "#to_s" do
        it "returns a String" do
            header = NFE::Header.new
            header << {municipal_registration: "48815400"}
            expect(header.to_s).to be_an String
        end
    end
end
