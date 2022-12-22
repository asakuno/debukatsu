class GuestSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create]

  def create
    if current_user
      redirect_to root_path, alert: 'すでにログインしています'
    else
      @guest_user = User.guest_user_generate
      auto_login(@guest_user)
      redirect_to groups_path, notice: t('created')
    end
  end
end
