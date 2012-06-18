module FixnumBitExtension
  def bit i
    return (self & (1 << i)) != 0
  end
end

class Fixnum
  include FixnumBitExtension
end
