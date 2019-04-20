var search_data = {"index":{"searchIndex":["cosmos","aggregatepacketmapper","aggregatepacketprocesser","basenamemap","unpackinginterface","unpackinginterface","_extract_map()","_field_arity()","_max_arity()","agg_pkt_map()","build_map()","connect()","extract_all()","new()","new()","packet_mapper()","process()","read()","size()","target()","transforms()","unpack()"],"longSearchIndex":["cosmos","cosmos::aggregatepacketmapper","cosmos::aggregatepacketprocesser","cosmos::basenamemap","cosmos::unpackinginterface","unpackinginterface","cosmos::aggregatepacketprocesser#_extract_map()","cosmos::basenamemap#_field_arity()","cosmos::basenamemap#_max_arity()","cosmos::unpackinginterface#agg_pkt_map()","cosmos::aggregatepacketmapper#build_map()","cosmos::unpackinginterface#connect()","cosmos::basenamemap#extract_all()","cosmos::aggregatepacketprocesser::new()","cosmos::basenamemap::new()","cosmos::unpackinginterface#packet_mapper()","cosmos::unpackinginterface#process()","cosmos::unpackinginterface#read()","cosmos::basenamemap#size()","cosmos::unpackinginterface#target()","cosmos::unpackinginterface#transforms()","cosmos::aggregatepacketprocesser#unpack()"],"info":[["Cosmos","","Cosmos.html","","<p>Encapsulates the conversion of an aggregate packet into a BaseNameMap, our internal representation of …\n"],["Cosmos::AggregatePacketMapper","","Cosmos/AggregatePacketMapper.html","",""],["Cosmos::AggregatePacketProcesser","","Cosmos/AggregatePacketProcesser.html","","<p>Encapsulates the transformation of an aggregate packet into many simple packets\n"],["Cosmos::BaseNameMap","","Cosmos/BaseNameMap.html","",""],["Cosmos::UnpackingInterface","","Cosmos/UnpackingInterface.html","","<p>A custom interface that unpacks aggregate packets (packets with many granules) into many  simple packets …\n"],["UnpackingInterface","","UnpackingInterface.html","","<p>A custom extendable interface that unpacks aggregate packets (packets with many granules) into many  …\n"],["_extract_map","Cosmos::AggregatePacketProcesser","Cosmos/AggregatePacketProcesser.html#method-i-_extract_map","(map, target, item)","<p>Extract our internal BaseNameMap into an array of packets of type target/item, applying transformations …\n"],["_field_arity","Cosmos::BaseNameMap","Cosmos/BaseNameMap.html#method-i-_field_arity","(k)",""],["_max_arity","Cosmos::BaseNameMap","Cosmos/BaseNameMap.html#method-i-_max_arity","()",""],["agg_pkt_map","Cosmos::UnpackingInterface","Cosmos/UnpackingInterface.html#method-i-agg_pkt_map","()","<p>Maps aggregate packets (packets with many granules) to simple packets (packets with a single granule) …\n"],["build_map","Cosmos::AggregatePacketMapper","Cosmos/AggregatePacketMapper.html#method-i-build_map","(packet)","<p>Builds a BaseNameMap from a cosmos aggregate packet\n"],["connect","Cosmos::UnpackingInterface","Cosmos/UnpackingInterface.html#method-i-connect","()",""],["extract_all","Cosmos::BaseNameMap","Cosmos/BaseNameMap.html#method-i-extract_all","()","<p>Expands map of keys to arrays of values into a single array containing hashes where each key maps to …\n"],["new","Cosmos::AggregatePacketProcesser","Cosmos/AggregatePacketProcesser.html#method-c-new","(mapper, transforms = {})",""],["new","Cosmos::BaseNameMap","Cosmos/BaseNameMap.html#method-c-new","(map, name)","<p>map is a hash where keys are normalized item names (i.e. VALUE_A instead of VALUE_A_0) and  values are …\n"],["packet_mapper","Cosmos::UnpackingInterface","Cosmos/UnpackingInterface.html#method-i-packet_mapper","()","<p>Create and return a new instance of your own custom PacketMapper\n"],["process","Cosmos::UnpackingInterface","Cosmos/UnpackingInterface.html#method-i-process","(packet:, target:, agg_packet:, simple_packet:)","<p>Unpack an aggregate packet if necessary and add resulting packets to the internal FIFO queue\n"],["read","Cosmos::UnpackingInterface","Cosmos/UnpackingInterface.html#method-i-read","()","<p>This method is called by COSMOS internally, essentially if we have packets on the queue read those otherwise …\n"],["size","Cosmos::BaseNameMap","Cosmos/BaseNameMap.html#method-i-size","()","<p>Number of simple packets contained within the aggregate packet\n"],["target","Cosmos::UnpackingInterface","Cosmos/UnpackingInterface.html#method-i-target","()","<p>Cosmos target interface is being used with\n"],["transforms","Cosmos::UnpackingInterface","Cosmos/UnpackingInterface.html#method-i-transforms","()","<p>Transformations defined on an item in a simple packet. Entries should be of the form: “&lt;TARGET&gt;-&lt;PACKET_NAME&gt;-&lt;ITEM_NAME&gt;” …\n"],["unpack","Cosmos::AggregatePacketProcesser","Cosmos/AggregatePacketProcesser.html#method-i-unpack","(packet, target, item)","<p>Converts the aggregate packet into an array of simple packets.\n"]]}}