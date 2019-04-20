# UnpackingInterface

A custom extendable cosmos interface that unpacks aggregate packets (packets with many granules/datapoints) into many 
simple packets (packets with a single granule/datapoint). This way we can use all the cosmos niceties 
without having to send packets for individual measurements. Essentially we unpack an aggregate 
packet into many packets that are stored in a queue that is read from. When the queue is empty 
we look for new aggregate packets

For more information about cosmos interfaces look [here](https://cosmosrb.com/docs/interfaces/)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cosmos-unpacking_interface'
```

And then execute:

    $ bundle

Or install it yourself as:

```
    $ gem install cosmos-unpacking_interface
```

## Usage

You will likely need to define your own custom PacketMapper. A PacketMapper handles mapping a cosmos packet into our internal representation, a `BaseNameMap`. An example is given here:

```
require 'cosmos/unpacking_interface' 

##
# Example AggregatePacketMapper. This class encapsulates specific assumptions
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
```

A target is typically configured to use a specific interface in the `cmd_tlm_server.txt` file. In order to use the unpacking interface, you must add a ruby file `lib/my_interface` your cosmos project. It should define a class that extends `UnpackingInterface`. Then in your `cmd_tlm_server.txt` you should reference your file `lib/my_interface`. As an example: 

```
require 'cosmos'
require 'cosmos/unpacking_interface'

module Cosmos

## 
# Maps aggregate packets (packets with many granules/readings) to simple packets (packets with a single granule/readings)
# should have the form 'AggregatePacket' => 'SimplePacket'
# For example: 'Science' => 'Science2'
AGG_PKT_MAP = { 
  'AGGREGATE_PACKET_NAME' => 'SIMPLE_PACKET_NAME'
}

## 
# Transformations defined on an item in a simple packet. Entries should be of the
# form: "<TARGET>-<PACKET_NAME>-<ITEM_NAME>" => Proc
# where the proc can accept the following parameters TargetName, ItemName, key, value, index
# index is the index of the granule in the aggregate packet that was transformed into the simple packet
# More info about procs can be found here: https://ruby-doc.org/core-2.4.1/Proc.html
TRANSFORMS = {   
  'MYTARGET-PACKET-VALUE_A' => Proc.new do |target, item, key, value, index| 
      value # modify and return value
   end
}


TARGET = 'MYTARGER'

class MyInterface < UnpackingInterface
  def transforms
    TRANSFORMS
  end

  def agg_pkt_map
    AGG_PKT_MAP
  end

  def target
   TARGET
  end

  def packet_mapper
    MyPacketMapper.new
  end

end
end
```

## Development

Run `rake test` to run the tests. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nick-benoit14/cosmos-unpacking_interface

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
