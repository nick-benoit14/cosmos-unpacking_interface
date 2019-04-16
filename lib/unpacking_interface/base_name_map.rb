##
# Internal respresentation of an aggregate packet
module Cosmos
class BaseNameMap 
  attr_accessor :map, :name

  ##
  # map is a hash where keys are normalized item names (i.e. VALUE_A instead of VALUE_A_0) and 
  # values are arrays of all the values whose original keys (VALUE_A_x) mapped to that value. For example:
  # { 'VALUE_A' => [1,2,3]}.
  # 
  # name is the name of the packet
  def initialize(map, name)
    @map = map 
    @name = name # packet name
  end

  ##
  # Number of simple packets contained within the aggregate packet
  def size 
    if @map.empty?
      return 0
    else 
      _max_arity
    end
  end

  def _max_arity
    return 0 if @map.empty?
    @map.max_by {|k, v| v.length}.last.length
  end

  def _field_arity(k)
    result = @map[k]
    if result.nil?
      0
    else
      result.length
    end
  end

  ##
  # Expands map of keys to arrays of values into a single array containing hashes where
  # each key maps to only a single value
  # i.e. {'VALUE_A' => [1,2]} => [{'VALUE_A' => 1}, {'VALUE_A' => 2}]
  def extract_all 
   max = _max_arity
   range = if(max > 0)
     [*0..(max - 1)]
   else
     [0]
   end

   range.map do |i|
     keys = @map.keys
     keys.reduce({}) do |acc, k|
       if(_field_arity(k) == 1)
         acc[k] = @map[k].first
       else
         acc[k] = @map[k][i]
       end
       acc
     end 
   end
  end
end
end
