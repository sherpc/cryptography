require "./miller_rabin"

def read_number i
  File.open(ARGV[i], "r") do |f|
    f.readline.to_i
  end
end

def write_answer is_prime
  File.open(ARGV[1], "w") do |f|
    f << (is_prime ? 1 : 0)
  end
end

def check_number
  is_prime = read_number(0).prime?
  write_answer is_prime
end

def generate_prime
  n = read_number 1
  prime = Integer.generate_prime n
  File.open(ARGV[2], "w") { |f| f.puts(prime) }
end

def main
  return if ARGV[0].nil? && ARGV[1].nil?
  if ARGV[0] == "-g"
    generate_prime 
  else
    check_number
  end
end

if __FILE__ == $0
  main
end
