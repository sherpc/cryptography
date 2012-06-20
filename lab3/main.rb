def make_sqrt_list
  cache = { 1 => 1 }
  last_key = 1
  lambda { |x|
    return cache if cache.has_value?(x)
    while(last_key != x) do
      last_key += 1
      #p last_key
      cache[last_key * last_key] = last_key
    end
    cache
  }
end

Sqrt_list = make_sqrt_list

def is_sqrt? x, n
  y2 = x * x - n
  Sqrt_list[Math.sqrt(y2).ceil][y2]
end

def factorize n
  return 2, n / 2 if n % 2 == 0
  x = Math.sqrt(n).floor
  y = nil
  while(not y)
    x += 1
    y = is_sqrt?(x, n)
  end
  return x+y, x-y
end

def assert n
  x, y = factorize(n)
  p [x, y]
  raise "Error!" unless n == (x * y)
end
assert 34780051
