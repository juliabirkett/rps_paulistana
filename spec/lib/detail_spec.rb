require 'spec_helper'

describe NFE::Detail do
    describe "#new" do
        context "passing parameter(s)" do
            it "raises an ArgumentError" do
                expect{NFE::Detail.new "teste"}.to raise_error ArgumentError
            end
        end

        it "returns an NFE::Detail object" do
            expect(NFE::Detail.new).to be_an NFE::Detail
        end
    end

    describe "#<<" do
        context "with invalid parameter" do
            it "raises an InvalidParamError" do
                expect{NFE::Detail::new << "teste"}.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameter" do
            context "with nonexistent field" do
                it "raises an NonExistentFieldError" do
                    expect{NFE::Detail::new << {teste: "idk", nonexistent: "aa"}}.to raise_error NFE::Errors::NonExistentFieldError
                end
            end

            context "with invalid field" do
                it "raises an InvalidFieldError" do
                    expect{(NFE::Detail::new << {service_code: "01"})}.to raise_error NFE::Errors::InvalidFieldError
                end
            end

            context "with invalid field value (when the field has values restrictions)" do
                context "when :rps_type" do
                    it "raises RPSTypeError" do
                        expect{(NFE::Detail::new << {rps_type: "RPP"})}  .to raise_error NFE::Errors::RPSTypeError
                        expect{(NFE::Detail::new << {rps_type: "RAAAA"})}.to raise_error NFE::Errors::RPSTypeError
                    end
                end
                context "when :rps_status" do
                    it "raises RPSStatusError" do
                        expect{(NFE::Detail::new << {rps_status: "Z"})}  .to raise_error NFE::Errors::RPSStatusError
                        expect{(NFE::Detail::new << {rps_status: "W"})}  .to raise_error NFE::Errors::RPSStatusError
                    end
                end
                context "when :iss_by" do
                    it "raises ISSByError" do
                        expect{(NFE::Detail::new << {iss_by: "4"})}  .to raise_error NFE::Errors::ISSByError
                    end
                end
                context "when :taker_type" do
                    it "raises RPSTypeError" do
                        expect{(NFE::Detail::new << {taker_type: "5"})}  .to raise_error NFE::Errors::TakerTypeError
                    end
                end
                context "when :issuing_date" do
                    it "raises an ArgumentError" do
                        expect{(NFE::Detail.new << {issuing_date: "20166502"})}.to raise_error ArgumentError, /invalid date/
                    end
                end
            end

            context "with valid fields" do
                it "returns a populated Hash of field name/value" do
                    expect((NFE::Detail::new << {aliquot: "01", taker_type: "1"}).empty?)                       .to be false
                    expect((NFE::Detail::new << {amount: "0015", tax_amount: "0", iss_by: "3"}).empty?)         .to be false
                end
            end
        end
    end

    describe "#valid?" do
        it "return whether the register is valid (contains required fields)" do
            header = NFE::Detail.new
            expect(header.valid?).to be false
            header << {aliquot: "002", taker_type: "1", taker_document: "43896729837"}
            expect(header.valid?).to be false
            header << {rps_number: "1", amount: "100", tax_amount: "0", service_code: "06298"}
            expect(header.valid?).to be false
            header << {iss_by: "1"}
            expect(header.valid?).to be true

            #using DEFAUTLS
            header = NFE::Detail.new
            header << {
                rps_number: "2",
                amount: "1",
                tax_amount: "0",
                service_code: "06298",
                aliquot: "0",
                iss_by: "1",
                taker_type: "2",
                taker_document: "43896729837",
                rps_status: "A"
            }
            expect(header.valid?).to be true
        end
    end
end
