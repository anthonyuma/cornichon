module Cornichon
  class Config
    class << self
      def configure(opts)
        @relative_feature_path = opts[:features_path] if opts[:features_path]
        @relative_template_path = opts[:templates_path] if opts[:templates_path]
        @relative_presenter_path = opts[:presenters_path] if opts[:presenters_path]
      end

      def relative_feature_path
        @relative_feature_path ||= 'features/cornichon/features'
      end

      def relative_template_path
        @relative_template_path ||= 'features/cornichon/templates'
      end

      def relative_presenter_path
        @relative_presenter_path ||= 'features/cornichon/presenters'
      end
    end
  end
end