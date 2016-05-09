module NovaPoshta
  module Model
    class Address < ::NovaPoshta::Model::Base

      # find_by_string
      def get_cities(params={})
        api.request('getCities', params)
      end

      def get_warehouses(city_ref, params={})
        api.request('getWarehouses', {city_ref: city_ref}.merge(params))
      end

      def get_areas(params={})
        api.request('getAreas', params)
      end

    end
  end
end
