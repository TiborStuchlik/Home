class ProxyController < ApplicationController
  #require 'rails-reverse-proxy'
  include ReverseProxy::Controller

  def index
    # Assuming the WordPress server is being hosted on port 8080
    path = "/"
    path += params[:path] if params[:path]
    path += "." + params[:format] if params[:format]

    puts "load: " + path

    reverse_proxy "http://localhost:3001", { path: path} do |config|
      # We got a 404!
      config.on_missing do |code, response|
        redirect_to root_url and return
      end

      config.on_connect do |code, response|
        puts code
      end

      config.on_response do |a,b,s,d|
        puts "mam"
      end

      # There's also other callbacks:
      # - on_set_cookies
      # - on_connect
      # - on_response
      # - on_set_cookies
      # - on_success
      # - on_redirect
      # - on_missing
      # - on_error
      # - on_complete
    end
  end
end