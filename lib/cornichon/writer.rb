require "cornichon/config"
require "cornichon/parser"
require "fileutils"

module Cornichon
  class Writer
    class << self
      def write!(opts = {})
        $verbose = opts[:verbose]
        if $verbose
          puts "SETUP: templates at #{Config.relative_template_path}"
          puts "SETUP: presenters at #{Config.relative_presenter_path}"
          puts "SETUP: features written to #{Config.relative_feature_path}\n"
        end

        require_presenter_methods
        create_feature_dir

        templates.each { |template|
          template_name = File.basename(template, ".cornichon")
          feature_path = File.join(Dir.pwd, Config.relative_feature_path, "#{template_name}.feature")
          raw_feature = parse_template(template)
          IO.write(feature_path, raw_feature)
          puts "written #{feature_path}" if $verbose
        }
      end

      def templates
        @templates ||= Proc.new {
          full_path = File.join(Dir.pwd, Config.relative_template_path)
          Dir.glob("#{full_path}/*.cornichon")
        }.call
      end

      def parse_template(template_file)
        raw_template = IO.read(template_file)
        Parser.parse(raw_template)
      end

      private

      def require_presenter_methods
        full_path = File.join(Dir.pwd, Config.relative_presenter_path)
        Dir.glob("#{full_path}/*.rb").each { |file|
          puts "SETUP: requiring #{file}" if $verbose
          require "#{file}"
        }
      end

      def create_feature_dir
        dir_path = File.join(Dir.pwd, Config.relative_feature_path)
        FileUtils.mkdir_p dir_path unless Dir.exist? dir_path
      end
    end
  end
end