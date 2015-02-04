require 'socket'

s = TCPSocket.new 'challenge2.airtime.com', 2323
initialresponse = false
success = false
while line = s.gets # Read lines from socket
    if success #Success message received
      File.open("test", 'a') { |file| file.write(line) }
    end
  if !loopthrough
  	number = line.match(/\d+/)
  	s.write "IAM:#{number}:test@now.com:at\n"
  	loopthrough = true
  end
  if !success 
    success = line.include?("SUCCESS")   
   end
end
 
s.close             # close socket when done