require "test/unit"
require "./main.rb"

class TestFixnumBitExtension < Test::Unit::TestCase
  def test_bit
    assert_equal true, 1.bit(0)
    assert_equal false, 1.bit(1)
    assert_equal true, 2.bit(1)
    assert_equal true, 3.bit(0)
  end

end

