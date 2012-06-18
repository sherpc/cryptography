module FixnumBitExtension
  def bit i
    return (self & (1 << i)) != 0
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
