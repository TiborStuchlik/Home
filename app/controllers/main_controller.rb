class MainController < ApplicationController
  def index
    @os = Gem::Platform.local
    puts @os
  end
end
