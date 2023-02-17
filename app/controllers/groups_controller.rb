class GroupsController < ApplicationController
  def index
    @groups = Group.includes(%i[user foods]).references(:all).order(created_at: :desc).page(params[:page])
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @foods = if params[:tag_name].present?
               .includes(%i[taggings user groups]).references(:all).order(created_at: :desc)
             else
               Food.includes(%i[taggings user groups]).references(:all).order(created_at: :desc)
             end
  end

  def create
    # GroupJob.perform_later(current_user.id, group_params)
    # group.food_ids = @best_foods
    # redirect_to groups_path, notice: 'Group was successfully created.'
    @group = Group.new(group_params)
    @group.user_id = current_user.id

    @group.high_calorie(@group.maximum_amount, @group.food_ids)

    group_params[:food_ids].each do |groupg|
      foods = @group.foods.pluck(:food_id)
      unless foods.include?(groupg.to_i)
        food = SelectFood.new(food_id: groupg)
        food.group_id = @group.id
      end
    end

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
