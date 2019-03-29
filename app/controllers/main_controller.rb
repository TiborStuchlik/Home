class MainController < ApplicationController
  def index
    @os = Gem::Platform.local
    @temp = %x( cat /sys/class/thermal/thermal_zone0/temp )
    puts @os
  end
end
