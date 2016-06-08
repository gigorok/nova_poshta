module NovaPoshta
  module Response
    class Area < ::NovaPoshta::Response::Base

      attr_accessor :description, :ref, :areas_center

      # ugly API do not provide searching by area reference
      def cities(params={})
        
        # return NovaPoshta::Result
        c = address.cities(params).select { |city| city.area_ref == self.ref }
        data = c.map do |city|
          {
              :'Description' => city.description,
              :'DescriptionRu' => city.description_ru,
              :'Ref' => city.ref,
              :'Delivery1' => city.delivery1,
              :'Delivery2' => city.delivery2,
              :'Delivery3' => city.delivery3,
              :'Delivery4' => city.delivery4,
              :'Delivery5' => city.delivery5,
              :'Delivery6' => city.delivery6,
              :'Delivery7' => city.delivery7,
              :'Area' => city.area_ref,
              :'Conglomerates' => city.conglomerates,
              :'CityID' => city.city_id,
          }
        end

        r = {
            success: true,
            data: data,
            errors: [],
            warnings: [],
            info: []
        }

        ::NovaPoshta::Result.new(r.to_json, 'getCities')
      end

    end
  end
end
