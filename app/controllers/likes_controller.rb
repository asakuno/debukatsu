class LikesController < ApplicationController
  def create
    @food = Food.find(params[:food_id])
    current_user.like(@food)
  end

  def destroy
    @food = current_user.likes.find(params[:id]).food
    current_user.unlike(@food)
  end
end
