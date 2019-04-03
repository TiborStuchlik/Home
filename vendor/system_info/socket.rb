require 'active_support/all'
require 'websocket-client-simple'

ws = WebSocket::Client::Simple.connect 'ws://localhost:3000/cable'

ws.on :message do |msg|
  puts msg.data
end

ws.on :open do
  #ws.send 'hello!!!'
  ws.send ({"command":"subscribe","identifier":"{\"channel\":\"ServerInfoChannel\",\"request_id\":\"b03e65bc-994c-d1e6-cd71-51b7a86242d8\"}"}.to_json)

end

ws.on :close do |e|
  p e
  exit 1
end

ws.on :error do |e|
  p e
end

loop do
  sleep 5
  #ws.send "tiba_pok"
  ws.send STDIN.gets.strip
end