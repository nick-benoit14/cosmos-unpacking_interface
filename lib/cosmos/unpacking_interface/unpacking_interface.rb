require 'cosmos'
require 'cosmos/interfaces/tcpip_server_interface'



module Cosmos

# We don't create the interface object, so the user should redefine an interface that extends ours but overrides pkt map transforms 

## 
# Maps aggregate packets (packets with many granules) to simple packets (packets with a single granule)
# should have the form 'AggregatePacket' => 'SimplePacket'
# For example: 'Science' => 'Science2'
#AGG_PKT_MAP = { 'TEST_1' => 'TEST',
#  'TEST_2' => 'TEST',
#  'Science' => 'Science2'
#}

# 
# Transformations defined on an item in a simple packet. Entries should be of the
# form: "<TARGET>-<PACKET_NAME>-<ITEM_NAME>" => Proc
# where the proc can accept the following parameters TargetName, ItemName, key, value, index
# index is the index of the granule in the aggregate packet that was transformed into the simple packet
# More info about procs can be found here: https://ruby-doc.org/core-2.4.1/Proc.html
#TRANSFORMS = {   
#  'PI-TEST-VALUE_D' => TimeTransformer.build_transform(1), # num milliseconds to advance clock for each granule
#  'PI-Science2-SYSCLOCK' => TimeTransformer.build_transform(10)
#}


## 
# A custom interface that unpacks aggregate packets (packets with many granules) into many 
# simple packets (packets with a single granule). This way we can use all the cosmos niceties 
# without having to send packets for individual measurements. Essentially we unpack an aggregate 
# packet into many packets that are stored in a queue that is read from. When the queue is empty 
# we look for new aggregate packets
class UnpackingInterface < TcpipServerInterface

  def transforms
    {}
  end

  def agg_pkt_map
    {}
  end

  def target
   ""
  end

  def connect
    @derived_queue = []
    super()
  end


  ## 
  # Unpack an aggregate packet if necessary and add resulting packets to the internal FIFO queue
  def process(packet:, target:, agg_packet:, simple_packet:)   
     agg_pkt = System.telemetry.packet(target, agg_packet)
     if(agg_pkt.identify?(packet.buffer))
       processor = AggregatePacketProcesser.new(SportPacketMapper.new, transforms)
       agg_pkt.buffer = packet.buffer.clone
       result = processor.unpack(agg_pkt, target, simple_packet)

       @derived_queue.concat(result)
     end
     return packet
  end

  ## 
  # This method is called by COSMOS internally, essentially if we have packets on the queue read those
  # otherwise wait for a packet, and unpack if necessary
  def read
    if !@derived_queue.empty?
      p1 = @derived_queue.shift
      return p1
    else

     # This is a blocking call to wait for an actual packet to come over the wire
     packet = super()

     agg_pkt_map.select do |agg_packet, simple_packet|
       agg_pkt = System.telemetry.packet(target, agg_packet)
       if(agg_pkt.identify?(packet.buffer))      
         process(packet: packet, target: target, agg_packet: agg_packet, simple_packet: simple_packet)
       end
     end
 
     return packet
    end 
  end
end
end
