module NovaPoshta
  module Response
    class Warehouse < ::NovaPoshta::Response::Base

      attr_accessor :description, :description_ru, :phone, :type_of_warehouse, :ref, :number, :city_ref,
                    :max_weight_allowed, :longitude, :latitude, :reception, :delivery, :schedule,
                    :site_key, :city_description, :city_description_ru, :post_finance, :pos_terminal,
                    :total_max_weight_allowed, :place_max_weight_allowed

      # ugly API do not provide searching by city reference
      def city(params={})
        address.cities(params).select { |city| city.ref == self.city_ref }.first.result
      end

    end
  end
end