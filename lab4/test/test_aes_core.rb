require "test/unit"
require "./main.rb"

class TestAESCore < Test::Unit::TestCase
  def test_sbox
    assert_equal 0x63, AESCore.sbox(0)
    assert_equal 0x7c, AESCore.sbox(1)
    assert_equal 0x76, AESCore.sbox(15)
  end
  
  def test_inv_sbox
    assert_equal 0x52, AESCore.inv_sbox(0)
    assert_equal 0x09, AESCore.inv_sbox(1)
  end
  
  def test_const
    assert_equal 4, AESCore::Nk
  end

  def test_key_expansion
    key = [216,87,142,223,132,88,206,6,251,197,187,118,165,140,92,164]
    w = AESCore.key_expansion(key)
    assert_equal 44, w.length
  end

  def test_state_from
    input = [52, 49, 32, 56, 50, 32, 56, 49, 32, 50, 97, 32, 52, 48, 32, 51]
    state = [[52, 50, 32, 52], [49, 32, 50, 48], [32, 56, 97, 32], [56, 49, 32, 51]]
    assert_equal state, AESCore.state_from(input)
  end

  def test_output_from
    state = [[52, 50, 32, 52], [49, 32, 50, 48], [32, 56, 97, 32], [56, 49, 32, 51]]
    output = [52, 49, 32, 56, 50, 32, 56, 49, 32, 50, 97, 32, 52, 48, 32, 51]
    assert_equal output, AESCore.output_from(state)
  end

  def test_scalar_mul
    v1 = [2,3,1,1]
    v2 = [23,106,234,73]
    assert_equal 51, AESCore.scalar_mul(v1, v2)
  end

  def test_cipher
    input = [95, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    key = [216,87,142,223,132,88,206,6,251,197,187,118,165,140,92,164]
    w = AESCore.key_expansion(key)
    cipher = [57, 92, 186, 30, 30, 209, 113, 117, 13, 128, 2, 213, 87, 232, 85, 238]
    assert_equal cipher, AESCore.cipher(input, w)
    assert_equal input, AESCore.inv_cipher(cipher, w)
  end
end

