module Cornichon
  class Config
    class << self
      def write_path
        "#{__dirname}"
      end
    end
  end
end