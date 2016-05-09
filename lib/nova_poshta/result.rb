module NovaPoshta
  class Result

    CALLER_MAP = {
        'getCities' => 'City',
        'getWarehouses' => 'Warehouse'
    }.freeze

    attr_accessor :success, :data, :errors, :warnings, :info
    attr_reader :body, :raw_body

    def initialize(raw_body, called_method, api)
      @raw_body = raw_body
      @body = JSON.parse(raw_body)
      @called_method = called_method
      @api = api
    end

    def success?
      body['success']
    end

    def data
      body['data'].map do |attrs|
        response_class.new(attrs, @api)
      end if body['data']
    end

    def errors
      body['errors']
    end

    def warnings
      body['warnings']
    end

    def info
      body['info']
    end

    protected

    def response_class
      "::NovaPoshta::Response::#{CALLER_MAP[@called_method]}".constantize
    end

  end
end
