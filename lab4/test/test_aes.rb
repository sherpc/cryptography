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

  def test_key_expansion
    key = [216,87,142,223,132,88,206,6,251,197,187,118,165,140,92,164]
    w = AES.key_expansion(key)
    assert_equal 44, w.length
  end

  def test_state_from
    input = [52, 49, 32, 56, 50, 32, 56, 49, 32, 50, 97, 32, 52, 48, 32, 51]
    state = [[52, 50, 32, 52], [49, 32, 50, 48], [32, 56, 97, 32], [56, 49, 32, 51]]
    assert_equal state, AES.state_from(input)
  end

  def test_output_from
    state = [[52, 50, 32, 52], [49, 32, 50, 48], [32, 56, 97, 32], [56, 49, 32, 51]]
    output = [52, 49, 32, 56, 50, 32, 56, 49, 32, 50, 97, 32, 52, 48, 32, 51]
    assert_equal output, AES.output_from(state)
  end

  def test_scalar_mul
    v1 = [2,3,1,1]
    v2 = [23,106,234,73]
    assert_equal 51, AES.scalar_mul(v1, v2)
  end

  def test_cipher
    input = [52, 49, 32, 56, 50, 32, 56, 49, 32, 50, 97, 32, 52, 48, 32, 51]
    key = [216,87,142,223,132,88,206,6,251,197,187,118,165,140,92,164]
    w = AES.key_expansion(key)
    AES.cipher(input, w)
  end
end

