#require 'aggregate_packet_mapper'
#require 'base_name_map'

module Cosmos

##
# Encapsulates the transformation of an aggregate packet into many simple packets
class AggregatePacketProcesser

  def initialize(mapper, transforms = {})
    @mapper = mapper
    @transforms = transforms
  end

  ##
  # Converts the aggregate packet into an array of simple packets.
  def unpack(packet, target, item) 
    values_map = @mapper.build_map(packet) # 
    _extract_map(values_map, target, item)
  end

  ##
  # Extract our internal BaseNameMap into an array of packets of type target/item, applying
  # transformations if applicable
  def _extract_map(map, target, item)
    map.extract_all.each_with_index.map do |m, i| 
     keys = m.keys
     pkt = System.telemetry.packet(target, item).clone 

     keys.reduce(pkt) do |p, key|
       value = m[key]
       transform_key = [target, item, key].join("-")

       if @transforms[transform_key]
         p.write(key, @transforms[transform_key].call(target, item, key, value, i))
       else
         p.write(key, value)
       end
       p
     end 
    end
  end
end
end
