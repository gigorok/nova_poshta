module NovaPoshta
  module Model
    class Base

      def api
        @api ||= Api.new(self.class.name.split('::').last)
      end

    end
  end
end
