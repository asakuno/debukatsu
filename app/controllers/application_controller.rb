# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end
end
