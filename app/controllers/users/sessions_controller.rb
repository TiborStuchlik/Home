# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  layout 'anonymous', only: [:new]

  # before_action :configure_sign_in_params, only: [:create]
  prepend_before_action :authenticate_scope!, only: [:list]
  prepend_before_action :timeoutable, only: [:list]

  def list
    @users = User.all
    respond_to do |format|
      format.html {
        if request.xhr?
          render partial: 'users'
        end
      }
      format.js
      format.xml  { render xml: @users.to_xml( only: [ :id, :name]) }
      format.json { render json: @users }
    end
  end



  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     super
     #cookies.signed[:last_app_request_at] = user_session["last_request_at"]
     cookies.signed[:channel_identifier] = SecureRandom.uuid
     #session[:last_app_request_at] = user_session["last_request_at"]
     puts "session vytvorena >>>>>> " + user_session["last_request_at"].to_s
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def timeoutable
    request.env["devise.skip_trackable"] = true
  end

end
