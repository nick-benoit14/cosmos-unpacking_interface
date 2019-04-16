
##
# Sport specific AggregatePacketMapper. This class is encapsulates sport specific assumptions
# that can be made in mapping an aggregate packet into a BaseNameMap
module Cosmos
class SportPacketMapper < AggregatePacketMapper

  ##
  # Maps an item name like 'VALUE_A_42' => 'VALUE_A'
  def _get_normalized_key(str)
    match = /(.+)_\d+/.match(str)
    return str if match.nil?

    m = match[1]
    if m.nil?
      str
    else
      m
    end end
  
  ##
  # Builds a BaseNameMap from an aggregate packet
  def build_map(packet)
    all_item_names = packet.items.keys
    
    map = all_item_names.reduce({}) do |acc, raw_key|
      value = packet.read(raw_key)
      key = _get_normalized_key(raw_key)

      if(_should_write(key))
        acc[key] = [] if(acc[key].nil?) 
        acc[key] << value 
      end

      acc
    end

    BaseNameMap.new(map, packet.packet_name)
  end
  
  ##
  # List of fields not to be included in BaseNameMap. These are mostly cosmos auto generated derived
  # fields
  def _should_write(k)
    not_allowed = [
    'RECEIVED_TIMESECONDS', 
    'RECEIVED_TIMEFORMATTED',
    'RECEIVED_COUNT',
    'PACKET_TIMESECONDS', 
    'PACKET_TIMEFORMATTED'
    ]
    !not_allowed.include?(k)
  end
end
end
