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

        DEFAULTS = {
            rps_type: "RPS",
            issuing_date: Time.now.to_date.strftime("%Y%m%d"),
            rps_status: "T",
            service_description: "Agenciamento de motoboy realizados através da plataforma 99motos"
        }

        def initialize
            super 6
        end
    end
end
