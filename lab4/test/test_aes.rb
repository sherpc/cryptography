require "test/unit"
require "./main.rb"

class TestAES < Test::Unit::TestCase
  def test_sbox
    assert_equal 0x63, AES.sbox(0)
    assert_equal 0x7c, AES.sbox(1)
  end

end

