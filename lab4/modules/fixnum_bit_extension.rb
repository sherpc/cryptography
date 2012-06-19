module FixnumBitExtension
  def bit i
    return (self & (1 << i)) != 0
  end

  def each_bit &block
    byte = self
    (0..7).each do |i| 
      yield(byte & 1)
      byte >>= 1
    end
  end

  def inject_bit r=0, &block
    self.each_bit { |b| r = yield r, b }
    r
  end

  def mul_x
    GF.mul02 self
  end

  def apply n=1, &block
    return self if n == 0
    yield self.apply(n-1, &block)
  end
end

class Fixnum
  include FixnumBitExtension
end
