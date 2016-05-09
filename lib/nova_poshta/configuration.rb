module NovaPoshta
  class Configuration
    attr_accessor :api_key

    def initialize
      @api_key = ENV['NOVA_POSHTA_API_KEY']
    end

  end
end
