##
# Factory to produce a proc that will increment a base value according to it's
# index in the aggregate packet
class TimeTransformer

  ##
  # step should be the amount of change for each granule. So if the time between measuring
  # each granule is 10 millis, and the clock value is also in millis, then step should be 10
  def self.build_transform(step) # => Proc
    Proc.new do |t, item, key, value, i| 
      value.to_i + (step * i)
    end
  end
end
