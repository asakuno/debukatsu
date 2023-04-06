class GroupsController < ApplicationController
  def index
    @groups = Group.includes(%i[user foods comments]).references(:all).order(created_at: :desc).page(params[:page])
  end

  def show
    @group = Group.find(params[:id])
    @foods = @group.foods.page(params[:page])
    @comment = Comment.new
    @comments = @group.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @group = Group.new
    @foods = if params[:tag_name].present?
               Food.tagged_with(params[:tag_name].to_s).includes(%i[taggings user groups]).references(:all).page(params[:page])
             else
               Food.includes(%i[taggings user groups]).references(:all).order(created_at: :desc)
             end
  end

  def create
    # GroupJob.perform_later(current_user.id, group_params)
    # group.food_ids = @best_foods
    # redirect_to groups_path, notice: 'Group was successfully created.'
    @group = current_user.groups.new(group_params)

    if @group.maximum_amount <= Food.where(id: @group.food_ids).sum(:price)

      @group.high_calorie(@group.maximum_amount, @group.food_ids)

    end
    group_params[:food_ids].each do |groupg|
      foods = @group.foods.pluck(:food_id)
      unless foods.include?(groupg.to_i)
        food = SelectFood.new(food_id: groupg)
        food.group_id = @group.id
      end
    end
    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy!
    redirect_to groups_path, success: t('.success')
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :maximum_amount, food_ids: [])
  end
end
