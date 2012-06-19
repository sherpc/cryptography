require "test/unit"
require "./main.rb"

class TestFixnumBitExtension < Test::Unit::TestCase
  def test_bit
    assert_equal true, 1.bit(0)
    assert_equal false, 1.bit(1)
    assert_equal true, 2.bit(1)
    assert_equal true, 3.bit(0)
  end

  def do_each_bit_test byte
    s = ""
    byte.each_bit { |b| s += b.to_s }
    assert s.start_with? byte.to_s(2).reverse
  end

  def test_each_bit
    do_each_bit_test 2
    do_each_bit_test 134
  end

  def test_inject_bit
    assert_equal 3, 14.inject_bit { |r, b| r + b }
  end

  def test_apply
    assert_equal 2, 1.apply(&:succ)
    assert_equal 4, 1.apply(3,&:succ)
    assert_equal 1, 1.apply(0,&:succ)
  end

  def test_mul_x
    assert_equal 0x78, 0x3c.mul_x
    assert_equal 0x63, 0xbc.mul_x
  end
end

