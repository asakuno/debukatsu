class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]
  def index
    @q = Food.ransack(params[:q])
    @foods = if params[:tag_name].present?
               @q.result(distinct: true).tagged_with("#{params[:tag_name]}").includes(%i[taggings user groups]).references(:all).page(params[:page])
             else
               @q.result(distinct: true).includes(%i[taggings user groups]).references(:all).order(created_at: :desc).page(params[:page])
             end
  end

  def show
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def edit
  end

  def update
    if @food.update(food_params)
      redirect_to foods_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end

  def destroy
    @food.destroy!
    redirect_to foods_path, success: t('.success')
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :calorie, :price, :image, :protein, :lipid, :sugar, :dietary_fiber, :table_salt, :tag_list)
  end

  def set_food
    @food = current_user.foods.find(params[:id])
  end
end
