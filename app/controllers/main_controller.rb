class MainController < ApplicationController
  def index
    @os = Gem::Platform.local
    @temp = %x( cat /sys/class/thermal/thermal_zone0/temp )
    puts @os
  end

  def input

    respond_to do |format|
      format.json do
        render json: { result: :ok}.to_json
      end
    end
  end
end
