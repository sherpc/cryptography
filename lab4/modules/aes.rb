module AES
  require 'digest/md5'
  def self.generate_key password
    hash = (Digest::MD5.digest password.pack("C*")).bytes.to_a
  end

  def self.encrypt_bytes data, password
    hash = (Digest::MD5.digest password.pack("C*")).bytes.to_a
    w = AESCore.key_expansion hash

    result = AESCore.cipher data[0...16], w
    return result

    (0...data.length).step(16).each do |i|
      input = data[i...i+16]
      input << 0 while input.length != 16
      result += AESCore.cipher(input, w)
    end
    result
  end

  def self.decrypt_bytes data, password
    hash = (Digest::MD5.digest password.pack("C*")).bytes.to_a
    w = AESCore.key_expansion hash

    result = AESCore.inv_cipher data[0...16], w
    return result
    result = []

    (16...data.length).step(16).each do |i|
      result += AESCore.inv_cipher(data[i...i+16], w)
    end

    length = merge length
    result = result.first(length) if (length >= 0 && length <= result.length)
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

  def self.merge bytes
    res = 0
    (bytes.length-1).downto(0).each { |i| res = (res << 8) | bytes[i] }
    res
  end
end
