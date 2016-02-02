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
                expect(NFE::Helper::RPSField.new :field, "value").to be_an NFE::Helper::RPSField
            end
        end
    end

    describe "#check_value" do
        context "with invalid field value" do
            it "raises an Error" do
                expect{ (NFE::Helper::RPSField.new :layout_version, "100").check_value }.to raise_error NFE::Errors::LayoutVersionError
                expect{ (NFE::Helper::RPSField.new :rps_type, "JUL").check_value }      .to raise_error NFE::Errors::RPSTypeError
                expect{ (NFE::Helper::RPSField.new :rps_status, "Z").check_value }      .to raise_error NFE::Errors::RPSStatusError
                expect{ (NFE::Helper::RPSField.new :iss_by, "0").check_value }          .to raise_error NFE::Errors::ISSByError
                expect{ (NFE::Helper::RPSField.new :taker_type, "0").check_value }      .to raise_error NFE::Errors::TakerTypeError
            end
        end

        context "with valid field value" do
            it "do not raise Error" do
                expect{ (NFE::Helper::RPSField.new :layout_version, "001").check_value }.to_not raise_error
                expect{ (NFE::Helper::RPSField.new :rps_type, "RPS").check_value }      .to_not raise_error
                expect{ (NFE::Helper::RPSField.new :rps_status, "T").check_value }      .to_not raise_error
                expect{ (NFE::Helper::RPSField.new :iss_by, "1").check_value }          .to_not raise_error
                expect{ (NFE::Helper::RPSField.new :taker_type, "2").check_value }      .to_not raise_error
            end
        end
    end

    describe "#valid?" do
        context "with valid field name" do
            it "returns whether a RPSField value is valid" do
                expect((NFE::Helper::RPSField.new :uf, "SP").valid?)                                .to be true
                expect((NFE::Helper::RPSField.new :iss_by, "2").valid?)                             .to be true
                expect((NFE::Helper::RPSField.new :rps_type, "RPS").valid?)                         .to be true
                expect((NFE::Helper::RPSField.new :rps_status, "T").valid?)                         .to be true
                expect((NFE::Helper::RPSField.new :taker_type, "1").valid?)                         .to be true
                expect((NFE::Helper::RPSField.new :aliquot, "0500").valid?)                         .to be true
                expect((NFE::Helper::RPSField.new :start_date, "20160101").valid?)                  .to be true
                expect((NFE::Helper::RPSField.new :end_date, "20160101").valid?)                    .to be true
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

                expect((NFE::Helper::RPSField.new :uf, "SPRJ").valid?)                              .to be false
                expect((NFE::Helper::RPSField.new :iss_by, "J").valid?)                             .to be false
                expect((NFE::Helper::RPSField.new :rps_type, "ASLKAAA").valid?)                     .to be false
                expect((NFE::Helper::RPSField.new :rps_status, "LALA").valid?)                      .to be false
                expect((NFE::Helper::RPSField.new :taker_type, "444").valid?)                       .to be false
                expect((NFE::Helper::RPSField.new :aliquot, "la").valid?)                           .to be false
                expect((NFE::Helper::RPSField.new :start_date, "201601012").valid?)                 .to be false
                expect((NFE::Helper::RPSField.new :end_date, "201601012").valid?)                   .to be false
                expect((NFE::Helper::RPSField.new :city, "SAO PAULO!").valid?)                      .to be false
                expect((NFE::Helper::RPSField.new :address_type, "AVAAA").valid?)                   .to be false
                expect((NFE::Helper::RPSField.new :rps_serial, "AKSSDASF").valid?)                  .to be false
                expect((NFE::Helper::RPSField.new :address, "MARANHA@@@O").valid?)                  .to be false
                expect((NFE::Helper::RPSField.new :complement, "$").valid?)                         .to be false
                expect((NFE::Helper::RPSField.new :zip_code, "021225001").valid?)                   .to be false
                expect((NFE::Helper::RPSField.new :layout_version, "0s02").valid?)                  .to be false
                expect((NFE::Helper::RPSField.new :address_number, "sa600sa600sa600").valid?)       .to be false
                expect((NFE::Helper::RPSField.new :service_code, "asdd").valid?)                    .to be false
                expect((NFE::Helper::RPSField.new :district, "HIGIENOP@@OLIS").valid?)              .to be false
                expect((NFE::Helper::RPSField.new :amount, "000000000050a085").valid?)              .to be false
                expect((NFE::Helper::RPSField.new :city_ibge_code, "åsdas").valid?)                 .to be false
                expect((NFE::Helper::RPSField.new :rps_number, "000000000@001").valid?)             .to be false
                expect((NFE::Helper::RPSField.new :tributary_source, "idontknow!!").valid?)         .to be false
                expect((NFE::Helper::RPSField.new :tributary_percentage, "60023232").valid?)        .to be false
                expect((NFE::Helper::RPSField.new :taker_document, "438967298371212332").valid?)    .to be false
                expect((NFE::Helper::RPSField.new :total_detail_lines, "0000005!").valid?)          .to be false
                expect((NFE::Helper::RPSField.new :municipal_registration, "4881aaa5446").valid?)   .to be false
                expect((NFE::Helper::RPSField.new :taker_name, "FERNANDO FARIA DE SOUZ!!@A").valid?).to be false
                expect((NFE::Helper::RPSField.new :service_description, "Agenciamento !de motoboy realizados através da plataforma 99motos").valid?).to be false
            end
        end

        context "with invalid field name" do
            it "raises an NonExistentFieldError" do
                expect{(NFE::Helper::RPSField.new :teste, "whatever").valid?}.to raise_error NFE::Errors::NonExistentFieldError
            end
        end
    end
end
