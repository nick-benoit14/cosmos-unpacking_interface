require 'cosmos/conversions/conversion'
module Cosmos
  class MultiFieldBitConversion  < Conversion
    def initialize(*args)
      super()
      @fields = args
    end

    def call(value, packet, buffer)      
      return 0 if @fields.empty?

      items = @fields.map {|f| packet.get_item(f)} 
      type = items.map{|i| i.data_type }.uniq.first
      size = items.map{|i| i.bit_size }.sum

      @converted_type = type 
      @converted_bit_size = size

      items.reduce(0) do |acc, item|
        shifted = acc << item.bit_size
        shifted|packet.read(item.name)
      end
    end
  end
end

