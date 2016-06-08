module NovaPoshta
  module Response
    class Base

      attr_accessor :result

      def initialize(attrs)
        attrs.each do |k, v|
          if self.respond_to?("#{k.to_s.underscore}=".to_sym) # map only defined
            self.public_send("#{k.to_s.underscore}=".to_sym, v)
          end
        end

        yield self if block_given?
      end

      def address
        @address ||= Model::Address.new
      end

    end
  end
end