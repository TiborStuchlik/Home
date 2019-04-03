class ServerInfoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tiba_server_info_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts "cleaning channel"
  end

  def speak(data)
    puts "prijato: " + data.to_s
    sleep 2
    ActionCable.server.broadcast(
        "tiba_server_info_channel",
        message: Time.now.to_s + ": " + data.inspect)
  end
end
