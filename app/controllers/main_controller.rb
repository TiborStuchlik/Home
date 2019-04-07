class MainController < ApplicationController
  def index
    @os = Gem::Platform.local
    @temp = %x( cat /sys/class/thermal/thermal_zone0/temp )
    puts @os
    #redis = Redis.new
    #@redis = redis.set("key", "redis pokus", { ex: 30})
    #@redis = redis.pttl("key")
    if rt = cookies.signed['remember_user_token']
      t = Time.at(rt[2].to_f).utc.in_time_zone('Europe/Prague')
    else
      t = "not remenber"
    end
    @redis = "#{current_user.remember_expires_at} | #{t}"
  end

  def input

    respond_to do |format|
      format.json do
        render json: { result: :ok}.to_json
      end
    end
  end
end
