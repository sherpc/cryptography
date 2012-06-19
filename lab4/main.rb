Dir[File.dirname(__FILE__) + '/modules/*.rb'].each {|file| require file }

if __FILE__ == $0
  case ARGV[0]
  when "-e"
    encrypted = AES.encrypt_bytes File.open(ARGV[1], "r:binary").bytes.to_a, "qwerty".bytes.to_a
    File.open(ARGV[2], "wb") do |output|
      encrypted.each { |byte| output.print byte.chr }
    end
  when "-d"
    decrypted = AES.decrypt_bytes File.open(ARGV[1], "r:binary").bytes.to_a, "qwerty".bytes.to_a
    File.open(ARGV[2], "wb") do |output|
      decrypted.each { |byte| output.print byte.chr }
    end
  end

end
