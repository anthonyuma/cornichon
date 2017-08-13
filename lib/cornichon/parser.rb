module Cornichon
  class Parser
    class << self
      def parse(template)
        template.gsub(/{{(.*?)}}|^(.*)\[\[(.*?)\]\]/) { |match|
          replacement = nil
          if $1
            replacement = get_string(call $1)
          elsif $3
            replacement = get_array(call($3), $2.length)
            replacement.prepend($2) if replacement
          end

          if replacement
            replacement
          else
            match
          end
        }
      end
      
      private
      
      def call(method)
        begin
          send method
        rescue
          nil
        end
      end
      
      def get_string(str)
        str.to_s if str
      end
      
      def get_array(array, lpad = 0)
        return nil unless array && array.is_a?(Array)
        
        all_keys = array.reduce([]) { |acc, obj|
          acc | obj.keys
        }
        # headings = '| ' << all_keys.join(' | ') << ' |'
        columns = all_keys.map { |key|
          max_width = key.length
          rows = [key] + array.map { |example|
            cell = example.fetch(key, "")
            max_width = cell.length if cell.length > max_width
            cell
          }
          rows.map! { |cell| cell.ljust(max_width) }
        }
        (0...columns.first.length).map { |i|
          first = '| '
          first.prepend(' ' * lpad) if i > 0 
          first << columns.map { |c| c[i] }.join(' | ') << ' |'
        }.join("\n")
      end
    end
  end
end