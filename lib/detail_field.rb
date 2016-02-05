module NFE
    class DetailField < RPSField
        VALID_NAMES = [
            :taker_email,
            :aliquot,
            :taker_document,
            :amount,
            :municipal_registration,
            :state_registration,
            :tax_amount,
            :rps_number,
            :taker_name,
            :address_type,
            :address,
            :city,
            :address_number,
            :tributary_source,
            :complement,
            :district,
            :rps_type,
            :rps_serial,
            :issuing_date,
            :taker_ccm,
            :zip_code,
            :cei,
            :service_code,
            :tributary_percentage,
            :iss_by,
            :taker_type,
            :city_ibge_code,
            :rps_status,
            :uf,
            :service_description,
            :pis_pasep,
            :cofins,
            :inss,
            :ir,
            :cssl
        ]

        def initialize name, value
            super
            raise Errors::NonExistentFieldError, /Register: #{self.class}; Name: #{@name}; Value: #{@value}/         if !self.class::VALID_NAMES.include?(@name.to_sym)
        end
    end
end
