module AES
  require 'digest/md5'
  def self.encrypt_bytes data, password
    hash = (Digest::MD5.digest password.pack("C*")).bytes.to_a
    w = AESCore.key_expansion hash

    length = split data.length, 16
    result = AESCore.cipher length, w

    (0...data.length).step(16).each do |i|
      input = data[i...i+16]
      input << 0 while input.length != 16
      result += AESCore.cipher(input, w)
    end
    result
  end

  def self.split int, bytes
    res = []
    for i in 0...bytes do
      res << (int & 0xff)
      int >>= 8
    end
    res
  end
end
