# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  layout 'anonymous', only: [:new]

  def new
    if current_user
      super
    else
      render :pre_registration
    end
  end

  def create
    # add custom create logic here
  end

  def update
    super
  end

end
