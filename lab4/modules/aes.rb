module AES
  Nk = 4
  Nb = 4
  Nr = 10

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

  def self.key_expansion key
    w = []
    (0..Nk).each { |i| w[i] = key[4*i, 4 * i + 3] }
    for i in Nk..(Nb * (Nr + 1)) do
      t = w[i-1]
      if i % Nk == 0
        
      end
    end
    w
  end
end
