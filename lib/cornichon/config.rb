module Cornichon
  class Config
    class << self
      def relative_feature_path
        'features/cornichon/features'
      end
      
      def relative_template_path
        'features/cornichon/templates'
      end
      
      def relative_presenter_path
        'features/cornichon/presenters'
      end
    end
  end
end