module NovaPoshta
  module Model
    class Base

      attr_accessor :api

      def api
        @api ||= Api.new(self.class.name.split('::').last)
      end

    end
  end
end
