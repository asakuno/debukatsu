class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to mypage_profile_path, success: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end
end
