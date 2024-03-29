# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :notice, :alert, :danger

  private

  def not_authenticated
    flash[:alert] = t('defaults.message.require_login')
    redirect_to login_path
  end
end
