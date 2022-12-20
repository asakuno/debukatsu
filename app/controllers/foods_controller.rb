class FoodsController < ApplicationController
  def index
    @foods = Food.all.includes(:user).order(created_at: :desc)
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    if @food.save
      redirect_to foods_path
    else
      flash.now[:danger] = "エラーメッセージ"
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :calorie, :price)
  end
end
