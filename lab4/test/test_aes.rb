require "test/unit"
require "./main.rb"

class TestAES < Test::Unit::TestCase
  def test_sbox
    assert_equal 0x63, AES.sbox(0)
    assert_equal 0x7c, AES.sbox(1)
    assert_equal 0x76, AES.sbox(15)
  end
  
  def test_invsbox
    assert_equal 0x52, AES.invsbox(0)
    assert_equal 0x09, AES.invsbox(1)
  end
  
  def test_const
    assert_equal 4, AES::Nk
  end
end

