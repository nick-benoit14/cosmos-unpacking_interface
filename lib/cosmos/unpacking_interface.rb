require "cosmos/unpacking_interface/version"
## 
# A custom extendable interface that unpacks aggregate packets (packets with many granules) into many 
# simple packets (packets with a single granule). This way we can use all the cosmos niceties 
# without having to send packets for individual measurements. Essentially we unpack an aggregate 
# packet into many packets that are stored in a queue that is read from. When the queue is empty 
# we look for new aggregate packets
module UnpackingInterface
end

require "cosmos/unpacking_interface/base_name_map"
require "cosmos/unpacking_interface/aggregate_packet_mapper"
require "cosmos/unpacking_interface/aggregate_packet_processor"
require "cosmos/unpacking_interface/unpacking_interface" 
