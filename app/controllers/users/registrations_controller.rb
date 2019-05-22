# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  layout 'anonymous', only: [:new]

  def new
    super
  end

  def create
    # add custom create logic here
  end

  def update
    super
  end

end
