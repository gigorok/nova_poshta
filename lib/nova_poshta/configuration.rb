module NovaPoshta
  class Configuration
    attr_writer :api_key

    def initialize
      @api_key = ENV['NOVA_POSHTA_API_KEY']
    end

    def api_key
      @api_key || (raise UndefinedApiKeyError.new)
    end

  end
end
