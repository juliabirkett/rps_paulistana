require 'spec_helper'

describe NFE::DetailField do
    describe "#new" do
        context "with no parameters or not only two paremeters" do
            it "raises an ArgumentError" do
                expect{ NFE::DetailField.new }           .to raise_error ArgumentError
                expect{ NFE::DetailField.new String.new }.to raise_error ArgumentError
            end
        end

        context "with invalid parameter type class" do
            it "raises InvalidParamError" do
                expect{ NFE::DetailField.new 10, String.new }.to raise_error NFE::Errors::InvalidParamError, /Parameter name must be String or Symbol/
                expect{ NFE::DetailField.new String.new, 10 }.to raise_error NFE::Errors::InvalidParamError, /Parameter value must be String/
            end
        end

        context "with empty String parameters" do
            it "raises an InvalidParamError" do
                expect{ NFE::DetailField.new "", "" }        .to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::DetailField.new String.new, "" }.to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::DetailField.new "", String.new }.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameters" do
            context "with valid field name" do
                it "returns a NFE::DetailField object" do
                    expect(NFE::DetailField.new "taker_email", "value")         .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :aliquot, "value")              .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :taker_document, "value")       .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "amount", "value")              .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "tax_amount", "value")          .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "rps_number", "value")          .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "taker_name", "value")          .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "address_type", "value")        .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "address", "value")             .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "city", "value")                .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :address_number, "value")       .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :tributary_source, "value")     .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :complement, "value")           .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :district, "value")             .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :rps_type, "value")             .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :rps_serial, "value")           .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :issuing_date, "value")         .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "taker_ccm", "value")           .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :zip_code, "value")             .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "cei", "value")                 .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :service_code, "value")         .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "tributary_percentage", "value").to be_an NFE::DetailField
                    expect(NFE::DetailField.new :iss_by, "value")               .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "taker_type", "value")          .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :city_ibge_code, "value")       .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "rps_status", "value")          .to be_an NFE::DetailField
                    expect(NFE::DetailField.new :uf, "value")                   .to be_an NFE::DetailField
                    expect(NFE::DetailField.new "service_description", "value") .to be_an NFE::DetailField
                end
            end

            context "with invalid field name" do
                it "raises a NonExistentFieldError" do
                    expect{NFE::DetailField.new "field", "value"}             .to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::DetailField.new :field, "value"}              .to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::DetailField.new "layout_version", "value"}    .to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::DetailField.new :layout_version, "value"}     .to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::DetailField.new "total_detail_lines", "value"}.to raise_error NFE::Errors::NonExistentFieldError
                    expect{NFE::DetailField.new :total_detail_lines, "value"} .to raise_error NFE::Errors::NonExistentFieldError
                end
            end
        end
    end

    describe "#check_value" do
        context "with invalid field value" do
            it "raises an Error" do
                expect{ (NFE::DetailField.new :rps_type, "100").check_value }         .to raise_error NFE::Errors::RPSTypeError
                expect{ (NFE::DetailField.new :rps_status, "100").check_value }       .to raise_error NFE::Errors::RPSStatusError
                expect{ (NFE::DetailField.new :iss_by, "100").check_value }           .to raise_error NFE::Errors::ISSByError
                expect{ (NFE::DetailField.new :taker_type, "100").check_value }       .to raise_error NFE::Errors::TakerTypeError
                expect{ (NFE::DetailField.new :issuing_date, "20162908").check_value }.to raise_error ArgumentError, /invalid date/
            end
        end

        context "with valid field value" do
            it "do not raise Error" do
                expect{ (NFE::DetailField.new :rps_type, "RPS").check_value }         .to_not raise_error
                expect{ (NFE::DetailField.new :rps_status, "F").check_value }         .to_not raise_error
                expect{ (NFE::DetailField.new :iss_by, "1").check_value }             .to_not raise_error
                expect{ (NFE::DetailField.new :taker_type, "3").check_value }         .to_not raise_error
                expect{ (NFE::DetailField.new :issuing_date, "20160108").check_value }.to_not raise_error
            end
        end
    end

    describe "#valid?" do
        context "with valid field name" do
            it "returns whether a DetailField value is valid" do
                expect((NFE::DetailField.new :uf, "SP").valid?)                                .to be true
                expect((NFE::DetailField.new :iss_by, "2").valid?)                             .to be true
                expect((NFE::DetailField.new :rps_type, "RPS").valid?)                         .to be true
                expect((NFE::DetailField.new :rps_status, "T").valid?)                         .to be true
                expect((NFE::DetailField.new :taker_type, "1").valid?)                         .to be true
                expect((NFE::DetailField.new :aliquot, "0500").valid?)                         .to be true
                expect((NFE::DetailField.new :city, "SAO PAULO").valid?)                       .to be true
                expect((NFE::DetailField.new :address_type, "AV").valid?)                      .to be true
                expect((NFE::DetailField.new :rps_serial, "12345").valid?)                     .to be true
                expect((NFE::DetailField.new :address_type, "RUA").valid?)                     .to be true
                expect((NFE::DetailField.new :address, "MARANHAO").valid?)                     .to be true
                expect((NFE::DetailField.new :complement, "FUNDOS").valid?)                    .to be true
                expect((NFE::DetailField.new :zip_code, "01225001").valid?)                    .to be true
                expect((NFE::DetailField.new :address_number, "600").valid?)                   .to be true
                expect((NFE::DetailField.new :service_code, "06157").valid?)                   .to be true
                expect((NFE::DetailField.new :district, "HIGIENOPOLIS").valid?)                .to be true
                expect((NFE::DetailField.new :amount, "000000000050085").valid?)               .to be true
                expect((NFE::DetailField.new :tax_amount, "000000000050085").valid?)           .to be true
                expect((NFE::DetailField.new :city_ibge_code, "1234567").valid?)               .to be true
                expect((NFE::DetailField.new :rps_number, "000000000001").valid?)              .to be true
                expect((NFE::DetailField.new :tributary_source, "idontknow").valid?)           .to be true
                expect((NFE::DetailField.new :tributary_percentage, "60023").valid?)           .to be true
                expect((NFE::DetailField.new :taker_document, "43896729837").valid?)           .to be true
                expect((NFE::DetailField.new :taker_name, "FERNANDO FARIA DE SOUZA").valid?)   .to be true
                expect((NFE::DetailField.new :taker_email, "julia.birkett@99motos.com").valid?).to be true
                expect((NFE::DetailField.new :issuing_date, "20160102").valid?)                .to be true
                expect((NFE::DetailField.new :service_description, "Agenciamento de motoboy realizados através da plataforma 99motos").valid?).to be true

                expect((NFE::DetailField.new :uf, "SPRJ").valid?)                              .to be false
                expect((NFE::DetailField.new :iss_by, "J").valid?)                             .to be false
                expect((NFE::DetailField.new :rps_type, "ASLKAAA").valid?)                     .to be false
                expect((NFE::DetailField.new :rps_status, "LALA").valid?)                      .to be false
                expect((NFE::DetailField.new :taker_type, "444").valid?)                       .to be false
                expect((NFE::DetailField.new :aliquot, "la").valid?)                           .to be false
                expect((NFE::DetailField.new :city, "SAO PAULO!").valid?)                      .to be false
                expect((NFE::DetailField.new :address_type, "AVAAA").valid?)                   .to be false
                expect((NFE::DetailField.new :rps_serial, "AKSSDASF").valid?)                  .to be false
                expect((NFE::DetailField.new :address, "MARANHA@@@O").valid?)                  .to be false
                expect((NFE::DetailField.new :complement, "$").valid?)                         .to be false
                expect((NFE::DetailField.new :zip_code, "021225001").valid?)                   .to be false
                expect((NFE::DetailField.new :address_number, "sa600sa600sa600").valid?)       .to be false
                expect((NFE::DetailField.new :service_code, "asdd").valid?)                    .to be false
                expect((NFE::DetailField.new :district, "HIGIENOP@@OLIS").valid?)              .to be false
                expect((NFE::DetailField.new :amount, "000000000050a085").valid?)              .to be false
                expect((NFE::DetailField.new :tax_amount, "000000000050a085").valid?)          .to be false
                expect((NFE::DetailField.new :city_ibge_code, "åsdas").valid?)                 .to be false
                expect((NFE::DetailField.new :rps_number, "000000000@001").valid?)             .to be false
                expect((NFE::DetailField.new :tributary_source, "idontknow!!").valid?)         .to be false
                expect((NFE::DetailField.new :tributary_percentage, "60023232").valid?)        .to be false
                expect((NFE::DetailField.new :taker_document, "438967298371212332").valid?)    .to be false
                expect((NFE::DetailField.new :taker_name, "FERNANDO FARIA DE SOUZ!!@A").valid?).to be false
                expect((NFE::DetailField.new :issuing_date, "20160102a").valid?)               .to be false
                expect((NFE::DetailField.new :service_description, "!!!! 99motos").valid?)     .to be false
            end
        end
    end
end
