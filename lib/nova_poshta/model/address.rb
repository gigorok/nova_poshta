module NovaPoshta
  module Model
    class Address < ::NovaPoshta::Model::Base

      # you can use params as {find_by_string: 'Одесса'} to filter by city_name
      def cities(params={})
        api.request('getCities', params)
      end

      def warehouses(city_ref, params={})
        api.request('getWarehouses', {city_ref: city_ref}.merge(params))
      end

      def areas(params={})
        api.request('getAreas', params)
      end

    end
  end
end
