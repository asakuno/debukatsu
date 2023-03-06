class LikesController < ApplicationController
  def create
    food = Food.find(params[:food_id])
    current_user.like(food)
    redirect_back fallback_location: foods_path
  end

  def destroy
    food = current_user.likes_foods.find(params[:food_id])
    current_user.unlike(food)
    redirect_back fallback_location: foods_path
  end
end
