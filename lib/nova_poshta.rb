require 'active_support/all'

# require base classes because the order in this situation makes sense
require "nova_poshta/response/base"
require "nova_poshta/model/base"

Dir[File.dirname(__FILE__) + '/nova_poshta/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/nova_poshta/response/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/nova_poshta/model/*.rb'].each { |f| require f }

module NovaPoshta

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

end
