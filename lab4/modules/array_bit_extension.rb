module ArrayBitExtension
  def shift_left n=1
    self.slice(n, self.length) + self.slice(0, n)
  end

  def shift_right n=1
    self.shift_left(self.length-n)
  end

  def map_cell m=nil, &block
    return self.map { |r| r.map { |c| yield c } } unless m
    self.zip(m).map { |r1, r2| r1.zip(r2).map { |c1, c2| yield c1, c2 } }
  end
end

class Array
  include ArrayBitExtension
end
