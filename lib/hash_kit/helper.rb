module HashKit
  class Helper

    #This method is called to convert all the keys of a hash into symbols to allow consistent usage of hashes within your Ruby application.
    def symbolize(hash)
      {}.tap do |h|
        hash.each { |key, value| h[key.to_sym] = map_value_symbol(value) }
      end
    end

    #This method is called to convert all the keys of a hash into strings to allow consistent usage of hashes within your Ruby application.
    def stringify(hash)
      {}.tap do |h|
        hash.each { |key, value| h[key.to_s] = map_value_string(value) }
      end
    end

    private

    def map_value_symbol(thing)
      case thing
        when Hash
          symbolize(thing)
        when Array
          thing.map { |v| map_value_symbol(v) }
        else
          thing
      end
    end

    def map_value_string(thing)
      case thing
        when Hash
          stringify(thing)
        when Array
          thing.map { |v| map_value_string(v) }
        else
          thing
      end
    end
  end
end