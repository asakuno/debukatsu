class Mypage::LikesController < Mypage::BaseController
  def show
    @likes = current_user.likes_foods.includes(:user).order(created_at: :desc)
  end
end