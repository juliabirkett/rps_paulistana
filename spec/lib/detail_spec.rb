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
                    expect((NFE::Detail::new << {
                        rps_number: "3",
                        amount: "10",
                        tax_amount: "0",
                        service_code: "12345",
                        aliquot: "0",
                        iss_by: "1",
                        taker_type: "1",
                        taker_document: "43896729837"
                    }).empty?).to be false
                end
            end
        end
    end

    describe "#valid?" do
        it "return whether the register is valid (contains required fields)" do
            detail = NFE::Detail.new
            expect(detail.valid?).to be false
            detail << {
                rps_number: "3",
                amount: "10",
                tax_amount: "0",
                service_code: "12345",
                aliquot: "0",
                iss_by: "1",
                taker_type: "1",
                service_description: "Agenciamento de motoboy realizados através da plataforma 99motos"
            }
            expect(detail.valid?).to be false
            detail << {taker_document: "43896729837", rps_status: "t"}
            expect(detail.valid?).to be true

            #using DEFAUTLS
            detail = NFE::Detail.new
            detail << {
                rps_number: "2",
                amount: "1",
                tax_amount: "0",
                service_code: "06298",
                aliquot: "0",
                iss_by: "1",
                taker_type: "2",
                taker_document: "43896729837",
                rps_status: "A",
                service_description: "Agenciamento de motoboy realizados através da plataforma 99motos"
            }
            #false because taker_type is 2 and requires more fields
            expect(detail.valid?).to be false
            detail << {
                taker_name: "Julia Birkett",
                address_type: "AV",
                address: "Maranhao",
                address_number: "600",
                district: "Higienopolis",
                city: "Sao Paulo",
                uf: "SP"
            }
            expect(detail.valid?).to be true

            detail = NFE::Detail.new
            detail << {
                rps_number: "2",
                amount: "1",
                tax_amount: "0",
                service_code: "06298",
                aliquot: "0",
                iss_by: "1",
                taker_type: "1",
                taker_document: "43896729837",
                rps_status: "B",
                service_description: "Agenciamento de motoboy realizados através da plataforma 99motos"
            }
            #false because the rps_status is B and needs city_ibge_code
            expect(detail.valid?).to be false
            detail << { city_ibge_code: "12345" }
            expect(detail.valid?).to be true
        end
    end

    describe "#to_hash" do
        it "returns an Hash" do
            detail = NFE::Detail.new
            detail << {
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
            expect(detail.to_hash).to be_an Hash
        end
    end

    describe "#to_s" do
        context "with valid Detail" do
            it "returns a String" do
                detail = NFE::Detail.new
                detail << {
                    rps_number: "2",
                    amount: "1",
                    tax_amount: "0",
                    service_code: "06298",
                    aliquot: "0",
                    iss_by: "1",
                    taker_type: "1",
                    taker_document: "43896729837",
                    rps_status: "T",
                    service_description: "Agenciamento de motoboy realizados através da plataforma 99motos"
                }
                expect(detail.to_s).to be_an String
            end
        end

        context "with invalid Detail" do
            it "raises InvalidRegisterError" do
                detail = NFE::Detail.new
                detail << {taker_ccm: "12345678"}
                expect{detail.to_s}.to raise_error NFE::Errors::InvalidRegisterError
            end
        end
    end
end
