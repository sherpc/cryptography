Dir[File.dirname(__FILE__) + '/modules/*.rb'].each {|file| require file }

if __FILE__ == $0
end
