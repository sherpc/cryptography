class Integer
   def prime?(k = 50)
     n = self.abs()
     return true if n == 2
     return false if n == 1 || n & 1 == 0

     k.times do                               
       a = rand(n-2) + 1
       return false if n.witness? a
     end
     return true
   end

   def witness? a
     n = self
     n_1 = n - 1
     # n-1 = (2**t) * u, t>= 1, u.odd? == true, n.odd? == true
     u = n_1
     t = 0
     while u & 1 == 0
       u >>= 1 
       t += 1
     end
     x = ModMath.pow(a,u,n)
     x_next = nil
     (1..t).each do |i|
       x_next = (x * x) % n
       return true if x_next == 1 && x != 1 && x != n_1
       x = x_next
     end
     return x_next != 1
   end
end

class << Integer
  def generate_prime n
    until n.prime?
      n += 1
    end
    n
  end
end

module ModMath
   def ModMath.pow(base, power, mod)
     result = 1
     while power > 0
       result = (result * base) % mod if power & 1 == 1
       base = (base * base) % mod
       power >>= 1;
     end
     result
   end
end
