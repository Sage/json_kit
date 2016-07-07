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

      obj = JSON.parse(json)

      if [String, Fixnum, Numeric, Date, DateTime, Time, Integer].include?(obj.class)
        return json
      end

      if obj.is_a?(Array)
        return obj.map do |i|
          if klass != nil
            @hash_helper.from_hash(i, klass, transforms)
          else
            @hash_helper.symbolize(i)
          end
        end
      else
        if klass != nil
          return @hash_helper.from_hash(obj, klass, transforms)
        else
          return @hash_helper.symbolize(obj)
        end
      end

    end

  end
end