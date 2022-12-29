class FoodsController < ApplicationController
  def index
    @foods = Food.includes(%i[user groups]).references(:all).order(created_at: :desc).page(params[:page])
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
      flash.now[:danger] = 'エラーメッセージ'
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :calorie, :price, :image)
  end
end
