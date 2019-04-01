#require '/utils/init'
require 'action_cable_client'

puts __dir__
puts File.dirname(__dir__)
puts File.expand_path(File.dirname(__dir__))

EventMachine.run do

  uri = "ws://192.168.225.15:3000/cable/"
  client = ActionCableClient.new(uri, 'ServerInfoChannel', true, { "Origin" => "pokus.cz"})
  # called whenever a welcome message is received from the server

  client.subscribed do |m, n|
    puts 'subscribed.'
    puts m
    client.perform('speak', { message: 'hello from ruby client 1.0.0.0, test hub app' })
  end


  client.connected do |m|
    puts 'successfully connected.'
    puts m
  end

  # called whenever a message is received from the server
  client.received do | message |
    puts message
  end

  client.pinged do |data|
    puts data
  end

  # Sends a message to the sever, with the 'action', 'speak'
  # client.perform('speak', { message: 'hello from amc' })

end