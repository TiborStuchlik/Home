class ServerInfoChannel < ApplicationCable::Channel

  periodically :transmit_progress, every: 1.seconds


  def subscribed
    #stream_from 'alive'
    if params['stream_type'] == "public"
      stream_from "server_info_channel"
    else
      @private_session_identifier = connection.env['warden'].cookies.signed[:channel_identifier]
      stream_from @private_session_identifier
      @stop_stream = false
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
    puts "cleaning channel"
  end

  def speak(data)
    puts "prijato: " + data.to_s
    sleep 2
    ActionCable.server.broadcast(
        "server_info_channel",
        message: Time.now.to_s + ": " + data.inspect)
  end

  def alive(data)
    tr = current_user.timedout? Time.at( connection.env['warden'].session["last_request_at"])
    puts "user: #{current_user.email}, epiratin: #{tr}, connection: #{connection.env['warden'].cookies.signed[:channel_identifier]}"
    if tr #send info about expire app session
      ActionCable.server.broadcast(
          @private_session_identifier,
          type: 'expire',
          message: "session expired"
      )
    end
  end

  private

  def send_message( type, msg)
    ActionCable.server.broadcast(
        @private_session_identifier,
        type: type,
        message: msg
    )
  end


  def transmit_progress
    #pri remember me po vyprseni na kabelu odhlasi uzivatele pri timeout ho ponecha prihlaseneho
    if params['stream_type'] == "private"
      if @stop_stream
        unsubscribed
        return
      end
      if rut = connection.cook.signed['remember_user_token']
        t = Time.at(rut[2].to_f).utc #.in_time_zone('Europe/Prague')
        rea = t + Devise.remember_for - 2
        puts "#{rea} : #{Time.now.utc}"
        if Time.now.utc >= rea
          send_message( 'expire', "User session expired" )
          @stop_stream = true
        end
      elsif tr = current_user.timedout?(Time.at( connection.env['warden'].session["last_request_at"]))
        send_message( 'expire', "Default session expired. Check 'remember me' in sign in form for longer session time" )
        @stop_stream = true
      end
    end
  end

end
