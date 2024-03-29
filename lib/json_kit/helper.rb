module JsonKit
  class Helper

    def initialize
      @hash_helper = HashKit::Helper.new
    end

    def to_json(obj)
      if [String, Numeric, Date, DateTime, Time, Integer, TrueClass, FalseClass].include?(obj.class)
        return obj
      elsif obj.is_a?(Hash)
        return JSON.dump(obj)
      elsif obj.is_a?(Array)
        array = convert_array(obj)
        return JSON.dump(array)
      else
        hash = @hash_helper.to_hash(obj)
        return JSON.dump(hash)
      end
    end

    def from_json(json, klass = nil, transforms = [])

      obj = JSON.parse(json)

      if [String, Numeric, Date, DateTime, Time, Integer, TrueClass, FalseClass].include?(obj.class)
        return json
      end

      if obj.is_a?(Array)
        return obj.map do |i|
          if i.is_a?(Hash)
            if klass != nil
              @hash_helper.from_hash(i, klass, transforms)
            else i.is_a?(Hash)
              @hash_helper.symbolize(i)
            end
          else
            i
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

      private

      def convert_array(array)
        array.map do |i|
          if i.is_a?(Array)
            convert_array(i)
          elsif i.is_a?(Hash)
            i
          else
            @hash_helper.to_hash(i)
          end
        end
      end

  end
end
