module ArrayBitExtension
  def shift_left n=1
    self.slice(n, self.length) + self.slice(0, n)
  end
end

class Array
  include ArrayBitExtension
end
