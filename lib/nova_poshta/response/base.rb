module NovaPoshta
  module Response
    class Base

      def initialize(attrs, api = nil)
        attrs.each do |k, v|
          if self.respond_to?("#{k.underscore}=".to_sym) # map only defined
            self.public_send("#{k.underscore}=".to_sym, v)
          end
        end

        @api = api
      end

    end
  end
end