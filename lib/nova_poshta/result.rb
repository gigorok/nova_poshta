module NovaPoshta
  class Result

    include Enumerable

    attr_accessor :success, :data, :errors, :warnings, :info
    attr_reader :body, :raw_body

    def initialize(raw_body, called_method)
      @raw_body = raw_body
      @body = JSON.parse(raw_body)
      @called_method = called_method
    end

    def success?
      body['success']
    end

    def data
      body['data'].map do |attrs|
        response_class.new(attrs) do |r|
          r.result = self
        end
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

    def each(&block)
      data.each do |member|
        block.call(member)
      end
    end

    protected

    def response_class
      "::NovaPoshta::Response::#{@called_method[3..-1].singularize}".safe_constantize
    end

  end
end
