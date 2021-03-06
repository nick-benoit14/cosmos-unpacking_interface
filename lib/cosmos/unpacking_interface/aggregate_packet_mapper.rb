##
# Encapsulates the conversion of an aggregate packet into a BaseNameMap, our
# internal representation of the fields in an aggregate packet

module Cosmos
class AggregatePacketMapper

  ##
  # Builds a BaseNameMap from a cosmos aggregate packet
  def build_map(packet)
    BaseNameMap.new({}, packet.packet_name)
  end
end
end
