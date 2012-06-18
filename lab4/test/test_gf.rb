require "test/unit"
require "./main.rb"

class TestGF < Test::Unit::TestCase

  def test_mul02
    assert_equal 0x78, GF.mul02(0x3c)
    assert_equal 0x63, GF.mul02(0xbc)
  end

  def test_mul
    assert_equal 0xd4, GF.mul(0x3c, 0xa1)
  end

  def test_inv
    assert_equal 1, GF.mul(GF.inv(0x3c), 0x3c)
    assert_equal 1, GF.mul(GF.inv(0x2a), 0x2a)
    assert_equal nil, GF.inv(0)
  end
end
