module NovaPoshta
  module Response
    class Area < ::NovaPoshta::Response::Base

      attr_accessor :description, :ref, :areas_center
    end
  end
end