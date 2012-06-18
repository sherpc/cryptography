module GF
  def self.mul02 a
    highbit = a & 0x80
    # a * x, x = {02}, is equal to shift left. & with 0xff to cut overflows
    shift = (a << 1) & 0xff
    # If first bit is not 0 (a & 0x80 == 0), result is shift - m, where m = 0x011b, or m = x**8 + x**4 + x**3 + x + 1
    highbit == 0 ? shift : shift ^ 0x1b
  end

  def self.mul a, b
    (0..7).inject(0) { |r, i| b.bit(i) ? r ^ a.apply(i, &:mul_x) : r }
  end

  def self.inv a
    (0..255).find { |i| self.mul(i, a) == 1 }
  end
end
