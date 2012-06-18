module AES
  def self.sbox a
    m = 0xf8
    r = 0
    q = GF.inv(a) || 0

    for i in 0..7 do
      r = (r << 1) | bits.xorbits(q & m)
      m = (m >> 1) | ((m & 1) << 7)
    end

    r ^ 0x63
  end
end
