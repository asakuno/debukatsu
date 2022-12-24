class GroupsController < ApplicationController
  def index
    @groups = Group.includes([:user, :foods]).references(:all).order(created_at: :desc) 
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

    maximum_amount = @group.maximum_amount # 上限金額
    n = @group.food_ids.size # 数量

    # 値段とカロリーの配列を作成
    price_calorie = Array.new(n) { [] }

    @group.food_ids.each_with_index do |id, i|
      price_calorie[i] << Food.find(id).price
      price_calorie[i] << Food.find(id).calorie
    end
    
    # if文で分岐させたほうがいいかも？
    dp = Array.new(n + 1) { Array.new(maximum_amount + 1, 0) } 
    selection = Array.new(n + 1) { Array.new(maximum_amount + 1, '') }
    
    price_calorie.each_with_index do |(price, calorie), i|
      (0..maximum_amount).each do |j|
        # 商品i+1を選ばない場合
        dp[i + 1][j] = dp[i][j]
        selection[i + 1][j] = "#{selection[i][j]}0"
        if j - price >= 0 && (dp[i + 1][j] < dp[i][j - price] + calorie)
          # 商品i+1を選ぶ場合
          dp[i + 1][j] = dp[i][j - price] + calorie
          selection[i + 1][j] = "#{selection[i][j - price]}1"
        end
      end
    end

    best_foods = []

    (0..n - 1).each do |i|
      if selection[-1][-1].split('')[i] == '1'
        best_foods << @group.food_ids[i]
      end
    end

    @group.food_ids = best_foods

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
