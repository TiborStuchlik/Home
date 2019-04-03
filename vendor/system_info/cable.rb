require 'action_cable_client'

EventMachine.run do

  uri = "ws://127.0.0.1:3000/cable/"
  client = ActionCableClient.new(uri, 'ServerInfoChannel')
  # called whenever a welcome message is received from the server
  client.connected { puts 'successfully connected.' }

  # called whenever a message is received from the server
  client.received do | message |
    puts message
  end

  # Sends a message to the sever, with the 'action', 'speak'
  client.perform('speak', { message: 'hello from amc' })
end