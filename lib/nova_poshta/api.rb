require 'net/http'
require 'net/https'
require 'json'

module NovaPoshta
  class Api
    API_URL = 'https://api.novaposhta.ua/v2.0/json/'.freeze

    attr_accessor :api_key, :model_name

    def initialize(model_name)
      self.api_key = NovaPoshta.configuration.api_key
      self.model_name = model_name
    end

    def request(called_method, method_properties={})
      response = post(request_body(called_method, method_properties))
      ::NovaPoshta::Result.new(response, called_method, self)
    end

    def request_body(called_method, method_props={})
      camelize_keys(
          {
              api_key: api_key,
              model_name: model_name,
              called_method: called_method,
              method_properties: method_properties(method_props)
          }, :lower
      ).to_json
    end

    protected

    def method_properties(method_props)
      camelize_keys(method_props, :upper)
    end

    def post(req_body)
      uri = URI.parse(API_URL)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true if uri.scheme == 'https'
      req = Net::HTTP::Post.new(uri.path)
      req.body = req_body
      https.request(req).body
    end

    def camelize_keys(h, first_letter = :upper)
      h.keys.each do |k|
        new_key = k.to_s.camelize(first_letter)
        new_key = new_key.to_sym if k.is_a? Symbol
        h[new_key] = h.delete(k)
      end
      h
    end

  end
end
