module AES
  require 'digest/md5'
  def self.generate_key password
    hash = (Digest::MD5.digest password.pack("C*")).bytes.to_a
  end

  def self.encrypt_bytes data, password
    w = AESCore.key_expansion password
    AESCore.cipher data[0...16], w
  end

  def self.decrypt_bytes data, password
    w = AESCore.key_expansion password
    AESCore.inv_cipher data[0...16], w
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
