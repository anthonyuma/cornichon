module Cornichon
  class Writer
    class << self
      def write!
        puts __FILE__
      end
    end
  end
end