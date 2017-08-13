module Cornichon
  class Parser
    class << self
      def parse(template)
        template.gsub(/{{(.*?)}}|^(.*)\[\[(.*?)\]\]/) { |match|
          replacement = nil
          if $1
            replacement = handle_string $1.strip
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

      def handle_string(raw)
        retained = false
        if raw.start_with? '+'
          raw.slice!('+').lstrip!
          retained = true
        end

        value = call(raw, retained)

        get_string value
      end

      def inject_path(hash, path)
        return hash if path.empty?
        begin
          path.inject(hash, :[])
        rescue
          nil
        end
      end

      def retain_cache
        @retain_cache ||= Hash.new
      end

      def call(method, retained = false)
        value = nil

        key_path = method.split('.')
        first = key_path.first
        remainder = key_path.drop 1

        if retained
          value = retain_cache[first]
          return inject_path(value, remainder) if value
        end

        begin
          value = send first
        rescue
          return nil
        end

        if value
          retain_cache[first] = value
          value = inject_path(value, remainder)
        end
        value
      end

      def get_string(str)
        str.to_s if str
      end

      def get_array(array, lpad = 0)
        return nil unless array
        array = [array] if array.is_a?(Hash)
        return nil unless array.is_a?(Array)

        all_keys = array.reduce([]) { |acc, obj|
          acc | obj.keys
        }
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