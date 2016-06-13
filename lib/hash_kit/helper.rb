module HashKit
  class Helper

    #This method is called to convert all the keys of a hash into symbols to allow consistent usage of hashes within your Ruby application.
    def symbolize(hash)
      {}.tap do |h|
        hash.each { |key, value| h[key.to_sym] = map_value(value) }
      end
    end

    private

    def map_value(thing)
      case thing
        when Hash
          symbolize(thing)
        when Array
          thing.map { |v| map_value(v) }
        else
          thing
      end
    end
  end
end