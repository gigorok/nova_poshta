require "nova_poshta/version"
require "nova_poshta/configuration"
require "nova_poshta/api"
require "nova_poshta/response/base"
require "nova_poshta/response/area"
require "nova_poshta/response/city"
require "nova_poshta/response/warehouse"
require "nova_poshta/result"
require "nova_poshta/model/base"
require "nova_poshta/model/address"
require 'active_support/all'

module NovaPoshta

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

end
