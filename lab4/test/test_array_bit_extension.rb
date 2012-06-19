require "test/unit"
require "./main.rb"

class TestArrayBitExtension < Test::Unit::TestCase
  def test_shift_left
    assert_equal [2,3,4,1], [1,2,3,4].shift_left
  end
end

