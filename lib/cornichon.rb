require "cornichon/version"
require "cornichon/config"
require "cornichon/writer"

module Cornichon
  class << self
    def configure(opts)
      Config.configure(opts)
    end
  end
end
