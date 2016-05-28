module NovaPoshta
  module Response
    class Area < ::NovaPoshta::Response::Base

      attr_accessor :description, :ref, :areas_center

      # ugly API do not provide searching by area reference
      def cities(params={})
        @api.request('getCities', params).select { |city| city.area_ref == self.ref }
      end

    end
  end
end