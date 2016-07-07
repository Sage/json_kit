module JsonKit
  class Helper

    def initialize
      @hash_helper = HashKit::Helper.new
    end

    def to_json(obj)
      if [String, Fixnum, Numeric, Date, DateTime, Time, Integer].include?(obj.class)
        return obj
      elsif obj.is_a?(Hash)
        return JSON.dump(obj)
      else
        hash = @hash_helper.to_hash(obj)
        return JSON.dump(hash)
      end
    end

    def from_json(json, klass = nil, transforms = [])

      hash = JSON.load(json)

      if klass != nil
        return @hash_helper.from_hash(hash, klass, transforms)
      else
        return @hash_helper.symbolize(hash)
      end

    end

  end
end