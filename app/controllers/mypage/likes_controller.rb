class Mypage::LikesController < Mypage::BaseController
  def index
    @likes = current_user.like_foods.includes(%i[taggings user groups]).references(:all).order(created_at: :desc)
  end
end