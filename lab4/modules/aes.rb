module AES
  def self.sbox byte
    m = 0xf8
    r = 0
    q = GF.inv(byte) || 0

    for i in 0..7 do
      r = (r << 1) | (q & m).inject_bit { |r, b| r ^ b }
      m = (m >> 1) | ((m & 1) << 7)
    end

    r ^ 0x63
  end

  def self.invsbox byte
    (0..255).find { |i| self.sbox(i) == byte }
  end
end
