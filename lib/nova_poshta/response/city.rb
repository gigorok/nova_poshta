module NovaPoshta
  module Response
    class City < ::NovaPoshta::Response::Base

      attr_accessor :description, :description_ru, :ref, :delivery1, :delivery2, :delivery3, :delivery4,
                    :delivery5, :delivery6, :delivery7, :area, :conglomerates, :city_id

      def warehouses(params={})
        @api.request('getWarehouses', {city_ref: ref}.merge(params))
      end

    end
  end
end