module NovaPoshta
  module Response
    class City < ::NovaPoshta::Response::Base

      attr_accessor :description, :description_ru, :ref, :delivery1, :delivery2, :delivery3, :delivery4,
                    :delivery5, :delivery6, :delivery7, :area_ref, :conglomerates, :city_id

      def warehouses(params={})
        address.warehouses(self.ref, params)
      end

      def area(params={})
        address.areas(params).select { |area| area.ref == self.area_ref }.first.result
      end

      # city has area attribute, but it should be area_ref, so next writer will fix this situation
      def area=(area_ref)
        self.area_ref = area_ref
      end

    end
  end
end