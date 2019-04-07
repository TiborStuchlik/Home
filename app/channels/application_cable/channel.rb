module ApplicationCable
  class Channel < ActionCable::Channel::Base
    #delegate :session, to: :connection
    # dont allow the clients to call those methods
    #protected :session
  end
end
