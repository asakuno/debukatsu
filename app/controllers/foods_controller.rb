class FoodsController < ApplicationController
  def index
    if params[:tag_name].present?
      @foods = Food.tagged_with("#{params[:tag_name]}").includes(%i[taggings user groups]).references(:all).page(params[:page])
    else
      @foods = Food.includes(%i[taggings user groups]).references(:all).order(created_at: :desc).page(params[:page])
    end
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

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy!
    redirect_to foods_path, success: '削除しました'
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :calorie, :price, :image, :tag_list)
  end
end
