require_relative 'test_helper'
require 'cosmos'
require 'test/unit'
require 'pry'

module Cosmos


class TestAggregatePacketProcessor < Test::Unit::TestCase

    def self.build_agg_packet
      packet = System.telemetry.packet('PI', 'TEST_1')


      packet.write('TST_PK_ID', 150)
      packet.write('VALUE_A', 99)
      packet.write('VALUE_B', 99)

      packet.write('VALUE_C_0', 1)
      packet.write('VALUE_D_0', 2)
      packet.write('VALUE_C_1', 3)
      packet.write('VALUE_D_1', 4)
      packet.write('VALUE_C_2', 5)
      packet.write('VALUE_D_2', 6)
      packet
    end

    class TestAggregatPacketMapper < AggregatePacketMapper
        def build_map(p)
          packet = TestAggregatePacketProcessor.build_agg_packet
          BaseNameMap.new({
            "TST_PK_ID"=>[150],
            "VALUE_A"=>[99],
            "VALUE_B"=>[99],
            "HEAD_LENGTH"=>[0],
            "VALUE_C"=>[1, 3, 5],
            "VALUE_D"=>[2, 4, 6]
          }, packet.packet_name)
        end
    end

    def test_unpack
      packet = TestAggregatePacketProcessor.build_agg_packet
      expected_result = [[1,2], [3,4], [5,6]] 
      processor = AggregatePacketProcesser.new(TestAggregatPacketMapper.new(), {})
      result = processor.unpack(packet, 'PI', 'TEST')

      assert_equal result.length, 3
 
      result.zip(expected_result).each do |pair|
        pkt = pair[0]
        expected = pair[1]
        c = pkt.read('VALUE_C')   
        d = pkt.read('VALUE_D')   

        assert_equal c, expected[0]
        assert_equal d, expected[1]
      end
    end

    def test_unpack_with_transformations
      packet = TestAggregatePacketProcessor.build_agg_packet
      expected_result = [[1,2], [3,5], [5,8]] 

      transformation = Proc.new { |a, b, c, value, index|  value + index }

      processor = AggregatePacketProcesser.new(TestAggregatPacketMapper.new(), {
        'PI-TEST-VALUE_D' => transformation
      })

      result = processor.unpack(packet, 'PI', 'TEST')

      assert_equal result.length, 3
 
      result.zip(expected_result).each do |pair|
        pkt = pair[0]
        expected = pair[1]
        c = pkt.read('VALUE_C')   
        d = pkt.read('VALUE_D')   

        assert_equal c, expected[0]
        assert_equal d, expected[1]
      end
    end
end
end
