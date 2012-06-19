#!/usr/bin/ruby
Dir[File.dirname(__FILE__) + '/modules/*.rb'].each {|file| require file }

def write_bytes file, array
  File.open(file, "wb") do |output|
    array.each { |byte| output.print byte.chr }
  end
end

def read_bytes file
  File.open(file, "r:binary").bytes.to_a
end

if __FILE__ == $0
  case ARGV[0]
  when "-e"
    encrypted = AES.encrypt_bytes read_bytes(ARGV[1]), read_bytes(ARGV[2])
    write_bytes ARGV[3], encrypted
  when "-d"
    decrypted = AES.decrypt_bytes read_bytes(ARGV[1]), read_bytes(ARGV[2])
    write_bytes ARGV[3], decrypted
  when "-k"
    key = AES.generate_key read_bytes(ARGV[1])
    write_bytes ARGV[2], key
  end

end
