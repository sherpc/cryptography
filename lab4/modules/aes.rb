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

  def self.rcon i
    [1.apply(i-1, &:mul_x), 0, 0, 0]
  end

  def self.key_expansion key
    w = []
    (0..Nk).each { |i| w[i] = key[4*i..(4 * i + 3)] }
    for i in Nk...(Nb * (Nr + 1)) do
      t = w[i-1]
      if i % Nk == 0
        sboxs = t.shift_left.map { |x| self.sbox x }
        t = sboxs.zip(self.rcon(i / Nk)).map { |x, y| x ^ y }
      end
      w[i] = w[i - Nk].zip(t).map { |x, y| x ^ y }
    end
    w
  end

  def self.state_from input
    s = [[], [], [], []]
    input.each_with_index { |x, i| s[i % 4][i / 4] = x }
    s
  end

  def self.add_round_key s, w
    s.map_cell(w) { |c1,c2| c1 ^ c2 }
  end
  
  def self.apply_sbox s
    s.map_cell { |c| sbox c }
  end

  def self.shift_rows s
    r = []
    (0..3).each { |i| r[i] = s[i].shift_left(i) }
    r
  end

  def self.scalar_mul v1, v2
    v1.zip(v2).inject(0) { |s, x| s ^ GF.mul(x[0], x[1]) }
  end

  def self.mix_columns s, top_row
    for c in 0...Nb do
      col = []
      (0..3).each { |r| colr[r] = s[r][c] }
      k = toprow
      for r in 0..3 do
        s[r][c] = scalar_mul k, col
      end
    end
    s
  end

  def self.cipher input, w
    s = self.state_from input
    s = add_round_key s, w[0...Nb]
    for i in 1...Nr do
      s = apply_sbox s
      s = shift_rows s
    end

    s
  end
end
