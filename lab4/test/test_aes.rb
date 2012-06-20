require "test/unit"
require "./main.rb"

class TestAES < Test::Unit::TestCase
  def test_encrypt
    result = [180, 169, 41, 103, 168, 198, 75, 78, 121, 146, 164, 187, 99, 103, 180, 31, 9, 68, 99, 145, 118, 245, 191, 69, 164, 102, 137, 221, 111, 120, 223, 0, 31, 45, 215, 163, 113, 112, 67, 189, 147, 252, 78, 166, 213, 51, 180, 79]
    data = [116, 101, 115, 116, 116, 101, 115, 116, 116, 101, 115, 116, 116, 101, 115, 116, 116, 101, 115, 116, 116, 101, 115, 116]
    password = [113, 119, 101, 114, 116, 121]
    #assert_equal result, AES.encrypt_bytes(data, password)
    #assert_equal data, AES.decrypt_bytes(result, password)
  end
end

