require "cornichon/config"
require "cornichon/parser"
require "fileutils"

module Cornichon
  class Writer
    class << self
      def write!
        require_presenter_methods
        create_feature_dir

        templates.each { |template|
          template_name = File.basename(template, ".cornichon")
          feature_path = File.join(Dir.pwd, Config.relative_feature_path, "#{template_name}.feature")
          write_template(template)
        }
      end

      def templates
        @templates ||= Proc.new {
          full_path = File.join(Dir.pwd, Config.relative_template_path)
          Dir.glob("#{full_path}/*.cornichon")
        }.call
      end

      def write_template(template_file)
        raw_template = IO.read(template_file)
        puts raw_template
      end

      private

      def require_presenter_methods
        full_path = File.join(Dir.pwd, Config.relative_presenter_path)
        Dir.glob("#{full_path}/*.rb").each { |file|
          require "#{file}"
        }
      end

      def create_feature_dir
        FileUtils.mkdir_p File.join(Dir.pwd, Config.relative_feature_path)
      end
    end
  end
end