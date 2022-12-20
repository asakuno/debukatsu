class GroupsController < ApplicationController
  def index
    @groups = Group.includes(:foods)  
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @foods = Food.all
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    @group.food_ids = @group.food_ids.delete_if {|id| id % 2 == 0 }
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:group_name, food_ids:[])
  end
end

