class GroupsController < ApplicationController
  def index
    @groups = Group.includes(%i[user foods]).references(:all).order(created_at: :desc).page(params[:page])
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

    @group.high_calorie(@group.maximum_amount, @group.food_ids)

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :maximum_amount, food_ids: [])
  end
end
