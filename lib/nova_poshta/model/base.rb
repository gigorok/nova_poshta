module NovaPoshta
  module Model
    class Base

      protected

      def request(called_method, method_properties={})
        NovaPoshta.api.request(model_name, called_method, method_properties)
      end

      def model_name
        self.class.name.demodulize
      end

    end
  end
end
