##
# Encapsulates the conversion of an aggregate packet into a BaseNameMap, our
# internal representation of the fields in an aggregate packet
#require 'base_name_map'
module Cosmos
class AggregatePacketMapper
  def build_map(packet)
    BaseNameMap.new({}, packet.packet_name)
  end
end
end
