#!/usr/bin/ruby
module ModMath
   def self.pow(base, power, mod)
     result = 1
     while power > 0
       result = (result * base) % mod if power & 1 == 1
       base = (base * base) % mod
       power >>= 1;
     end
     result
   end
end
include Math

def EGCD a, b
  return a, 1, 0 if b == 0
  d1, x1, y1 = EGCD(b, a%b)
  d, x, y = d1, y1, x1 - (a/b)*y1
  return d, x, y
end

def nod a, b
  x, y, z = EGCD(a, b)
  x
end

def rev a, b
  x, y, z = EGCD(a, b)
  y
end

def base m
  t=[]
  
  m.times { t << 1 }
  t[0]=0
  t[1]=0
  for i in 2...(m/2)
    next if t[i] == 0
    j = 2 * i
    while j < m do
      if t[j] == 0
        j += i
        next
      end
      
      t[j] = 0 if t[j] % t[i] == 0
      j += i
    end
  end
  k=0
  q = []

  for i in 0...m
    if t[i] != 0
      q << i
      k += 1
    end
  end
  return q, k    
end

def expansion t, q, k
  a = []
  n = 0
  c = 0
  x = 0
  for i in 0...k
    c = 0
    while true
      if t == 1
        a << c
        n += 1
        x = 1
        break
      end

      if t % q[i] == 0
        t /= q[i]     
        c += 1
      else
        if c != 0
          a << c
          n += 1
          c = 0
        else
          a << 0
          n += 1
        end
        break
      end
    end
  end
  return 0 if x == 0
  a
end

def syst a, p, q, mq
  got = []
  check = []
  x = []
  y = []
  index = 0
  for i in 0...mq 
    check << 0
    x << 0
  end
  i = 1
  while true
    while true 
      n = ModMath.pow(a, i, p)
      nsaved = n
      if n != 1 
        if got.count(n) == 0 
          break
        else
          i += 1
        end
      else 
        i += 1
      end
    end

    temp = []
    count = 0
    ch = 0
    difference = 0
    xpower = 0
    for j in 0...mq 
      t = 0
      while true 
        if n % q[j] == 0 
          t += 1
          n = n / q[j]
        else
          break
        end
      end
      if t > 0 || x[j] == 0
        if nod(t, (p-1)) != 1 
          ch = 1
          temp = []
          break
        else 
          xpower = t
          xcurrent = j
          count += 1
        end
      elsif t > 0 || x[j] != 0 
        difference += t*x[j]
        t = 0
      end
      if count > 1 
        ch = 1
        break
      end
    end
    
    if n == 1 || ch != 1 || xpower != 0 || count == 1 
      got << nsaved
      y = rev(xpower, (p-1))
      x[xcurrent] = ((i - difference) * y) % (p - 1)
      index += 1
      break if index == mq 
    end
    break if i == p - 1
    if p > 1000000 
      i = (i + p % 100000) % p
    else 
      i = i + 1
    end
  end
  x
end


def discrete_log a, b, p
  m = exp(0.75 * sqrt(log(p) * log(log(p)))).to_i
  q, mq = base(m + 1)

  x = syst(a, p, q, mq)
  h =[]
  ln = 0
  while ModMath.pow(a, ln, p) != b
    for i in 0...p
      f = 1 + rand(p - 2)
      h = expansion((ModMath.pow(a, f, p) * b) % p, q, mq)
      break if h != 0
      return 0 if i == 2 * p - 1
    end
    ln = 0
    (0...mq).each { |i| ln += h[i] * x[i] }
    ln %= (p - 1)
    ln -= f
    ln %= (p - 1)
  end
  return ln
end
        
def read_numbers
  File.open(ARGV[0], "r") do |f|
    f.readline.split.map(&:to_i)
  end
end

def write_answer x
  File.open(ARGV[1], "w") do |f|
    f << x
    f << "\n"
  end
end

def main 
  a, b, p = read_numbers
  x = discrete_log(a, b, p)
  write_answer x
end

if __FILE__ == $0
  main
end
#main 4, 7, 3
