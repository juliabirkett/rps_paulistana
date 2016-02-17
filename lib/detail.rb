module NFE
    class Detail < Register
        REQUIRED_FIELDS = [
            :rps_type,
            :rps_number,
            :issuing_date,
            :rps_status,
            :amount,
            :tax_amount,
            :service_code,
            :aliquot,
            :iss_by,
            :taker_type,
            :taker_document,
            :service_description
        ]

        VALID_FIELDS = [
            :rps_type,
            :rps_serial,
            :rps_number,
            :issuing_date,
            :rps_status,
            :amount,
            :tax_amount,
            :service_code,
            :aliquot,
            :iss_by,
            :taker_type,
            :taker_document,
            :taker_ccm,
            :state_registration,
            :taker_name,
            :address_type,
            :address,
            :address_number,
            :complement,
            :district,
            :city,
            #:uf,
            :zip_code,
            :taker_email,
            :pis_pasep,
            :cofins,
            :inss,
            :ir,
            :cssl,
            :total_tax_amount,
            :tributary_percentage,
            :tributary_source,
            :cei,
            :matriculation,
            :city_ibge_code,
            :private_blank_field,
            :service_description
        ]

        DEFAULTS = {
            rps_type: "RPS",
            issuing_date: Time.now.to_date.strftime("%Y%m%d")
        }

        def initialize
            super 6
        end

        def valid?
            fields_hash = self.to_hash
            if fields_hash[:taker_type].eql? "2"
               @required_fields.concat([
                   :taker_name,
                   :address_type,
                   :address,
                   :address_number,
                   :district,
                   :city,
                   #:uf,
               ])
           end

           if ["F", "B", "N", "V"].include?(fields_hash[:rps_status])
               @required_fields << :city_ibge_code
           end

           super
        end
    end
end
