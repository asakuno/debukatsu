class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if auth_params[:denied].present?
      redirect_to root_path, alert: 'ログインをキャンセルしました'
      return
    end
    if (@user = login_from(provider))
      redirect_to mypage_profile_path, success: "#{provider.titleize}でログインしました"
    else
      @user = create_from(provider)
      reset_session
      auto_login(@user)
      redirect_to mypage_profile_path, success: "#{provider.titleize}でログインしました"
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
