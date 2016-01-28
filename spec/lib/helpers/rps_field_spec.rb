require 'spec_helper'

describe NFE::Helper::RPSField do
    describe "#new" do
        context "with no parameters or not only two paremeters" do
            it "raises an ArgumentError" do
                expect{ NFE::Helper::RPSField.new }           .to raise_error ArgumentError
                expect{ NFE::Helper::RPSField.new String.new }.to raise_error ArgumentError
            end
        end

        context "with invalid parameter type class" do
            it "raises ParamClassError" do
                expect{ NFE::Helper::RPSField.new 10, String.new }.to raise_error NFE::Errors::ParamClassError, /Parameter name must be String or Symbol/
                expect{ NFE::Helper::RPSField.new String.new, 10 }.to raise_error NFE::Errors::ParamClassError, /Parameter value must be String/
            end
        end

        context "with empty String parameters" do
            it "raises an InvalidParamError" do
                expect{ NFE::Helper::RPSField.new "", "" }        .to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::Helper::RPSField.new String.new, "" }.to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::Helper::RPSField.new "", String.new }.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameters" do
            it "returns a NFE::Helper::RPSField object" do
                expect(NFE::Helper::RPSField.new "field", "value").to be_an NFE::Helper::RPSField
            end
        end
    end

    describe "#valid?" do
        it "returns true if the RPSField is a valid RPS field" do
            expect((NFE::Helper::RPSField.new :uf, "SP").valid?)                                .to be true
            expect((NFE::Helper::RPSField.new :iss_by, "2").valid?)                             .to be true
            expect((NFE::Helper::RPSField.new :rps_type, "RPS").valid?)                         .to be true
            expect((NFE::Helper::RPSField.new :rps_status, "T").valid?)                         .to be true
            expect((NFE::Helper::RPSField.new :taker_type, "1").valid?)                         .to be true
            expect((NFE::Helper::RPSField.new :aliquot, "0500").valid?)                         .to be true
            expect((NFE::Helper::RPSField.new :date, "20160101").valid?)                        .to be true
            expect((NFE::Helper::RPSField.new :city, "SAO PAULO").valid?)                       .to be true
            expect((NFE::Helper::RPSField.new :address_type, "AV").valid?)                      .to be true
            expect((NFE::Helper::RPSField.new :rps_serial, "12345").valid?)                     .to be true
            expect((NFE::Helper::RPSField.new :address_type, "RUA").valid?)                     .to be true
            expect((NFE::Helper::RPSField.new :address, "MARANHAO").valid?)                     .to be true
            expect((NFE::Helper::RPSField.new :complement, "FUNDOS").valid?)                    .to be true
            expect((NFE::Helper::RPSField.new :zip_code, "01225001").valid?)                    .to be true
            expect((NFE::Helper::RPSField.new :layout_version, "002").valid?)                   .to be true
            expect((NFE::Helper::RPSField.new :address_number, "600").valid?)                   .to be true
            expect((NFE::Helper::RPSField.new :service_code, "06157").valid?)                   .to be true
            expect((NFE::Helper::RPSField.new :district, "HIGIENOPOLIS").valid?)                .to be true
            expect((NFE::Helper::RPSField.new :amount, "000000000050085").valid?)               .to be true
            expect((NFE::Helper::RPSField.new :city_ibge_code, "1234567").valid?)               .to be true
            expect((NFE::Helper::RPSField.new :rps_number, "000000000001").valid?)              .to be true
            expect((NFE::Helper::RPSField.new :tributary_source, "idontknow").valid?)           .to be true
            expect((NFE::Helper::RPSField.new :tributary_percentage, "60023").valid?)           .to be true
            expect((NFE::Helper::RPSField.new :taker_document, "43896729837").valid?)           .to be true
            expect((NFE::Helper::RPSField.new :total_detail_lines, "0000005").valid?)           .to be true
            expect((NFE::Helper::RPSField.new :municipal_registration, "48815446").valid?)      .to be true
            expect((NFE::Helper::RPSField.new :taker_name, "FERNANDO FARIA DE SOUZA").valid?)   .to be true
            expect((NFE::Helper::RPSField.new :taker_email, "julia.birkett@99motos.com").valid?).to be true
            expect((NFE::Helper::RPSField.new :service_description, "Agenciamento de motoboy realizados através da plataforma 99motos").valid?).to be true
        end

        it "returns false if the RPSField is not a valid RPS field" do
            expect((NFE::Helper::RPSField.new :uf, "SPRJ").valid?)              .to be false
            expect((NFE::Helper::RPSField.new :zip_code, "teste").valid?)       .to be false
        end
    end
end
