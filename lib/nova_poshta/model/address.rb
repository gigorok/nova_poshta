module NovaPoshta
  module Model
    class Address < ::NovaPoshta::Model::Base

      # you can use params as {find_by_string: 'Одесса'} to filter by city_name
      def cities(params={})
        request('getCities', params)
      end

      def warehouses(city_ref, params={})
        request('getWarehouses', {city_ref: city_ref}.merge(params))
      end

      def areas(params={})
        request('getAreas', params)
      end

    end
  end
end
