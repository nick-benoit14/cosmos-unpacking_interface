require 'test_helper'

require 'cosmos'
require 'test/unit' 
require 'pry'

module Cosmos

class TestBaseNameMap < Test::Unit::TestCase

    def build_map
      BaseNameMap.new({
        "TST_PK_ID"=>[150],
        "VALUE_A"=>[99],
        "VALUE_B"=>[100],
        "HEAD_LENGTH"=>[0],
        "VALUE_C"=>[1, 3, 5],
        "VALUE_D"=>[2, 4, 6]
      }, "packet-name")
    end

    def test_extract_all
      map = build_map

      expected_result = [{
        "TST_PK_ID"=>150,
        "VALUE_A"=>99,
        "VALUE_B"=>100,
        "HEAD_LENGTH"=>0,
        "VALUE_C"=>1,
        "VALUE_D"=>2     
      },{
        "TST_PK_ID"=>150,
        "VALUE_A"=>99,
        "VALUE_B"=>100,
        "HEAD_LENGTH"=>0,
        "VALUE_C"=>3,
        "VALUE_D"=>4     
      },{
        "TST_PK_ID"=>150,
        "VALUE_A"=>99,
        "VALUE_B"=>100,
        "HEAD_LENGTH"=>0,
        "VALUE_C"=>5,
        "VALUE_D"=>6     
      }]

      result = map.extract_all
      assert_equal result, expected_result
    end
end
end
