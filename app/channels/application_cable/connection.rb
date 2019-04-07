
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    attr_accessor :cook

    def connect
      self.current_user = find_verified_user
      @cook = cookies
      puts self.current_user.inspect
    end

    def pokus
      "tiba"
    end

    protected

    def find_verified_user
      params = request.query_parameters

      #env['warden'].user  - pokud neni redis

      if verified_user = User.find_by(id: cookies.signed['user_id'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
