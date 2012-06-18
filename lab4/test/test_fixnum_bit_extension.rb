require "test/unit"
require "./main.rb"

class TestFixnumBitExtension < Test::Unit::TestCase
  def test_bit
    assert_equal true, 1.bit(0)
    assert_equal false, 1.bit(1)
    assert_equal true, 2.bit(1)
    assert_equal true, 3.bit(0)
  end

  def test_apply
    assert_equal 2, 1.apply(&:succ)
    assert_equal 4, 1.apply(3,&:succ)
  end

  def test_mul_x
    assert_equal 0x78, 0x3c.mul_x
    assert_equal 0x63, 0xbc.mul_x
  end
end

