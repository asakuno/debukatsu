class Mypage::LikesController < Mypage::BaseController
  def index
    @q = current_user.like_foods.ransack(params[:q])
    @likes = @q.result(distinct: true).includes(%i[taggings user groups]).references(:all).order(created_at: :desc)
  end
end
