class GroupsController < ApplicationController
  def index
    @groups = Group.includes(%i[user foods comments]).references(:all).where(publish: true).order(created_at: :desc).page(params[:page])
  end

  def mine
    @groups = current_user.groups.includes(%i[user foods comments]).references(:all).order(created_at: :desc).page(params[:page])
    render :index
  end

  def show
    @group = Group.find(params[:id])
    @foods = @group.foods.includes(%i[taggings user groups]).references(:all).page(params[:page])
    @comment = Comment.new
    @comments = @group.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @tags = Food.tags_on(:tags)
    @group = Group.new
    if params[:tag_name].present?
      @foods = Food.tagged_with(params[:tag_name].to_s).includes(%i[taggings user groups]).references(:all).page(params[:page])
    else
      @foods = Food.includes(%i[taggings user groups]).references(:all).order(created_at: :desc)
    end
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.maximum_amount <= Food.where(id: @group.food_ids).sum(:price)
      @group.high_calorie(@group.maximum_amount, @group.food_ids)
    end
    if @group.save
      group_params[:food_ids].each do |food_id|
        select_food = @group.select_foods.find_or_initialize_by(food_id: food_id)
        select_food.save
      end
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
    params.require(:group).permit(:group_name, :maximum_amount, :publish, food_ids: [])
  end
end
