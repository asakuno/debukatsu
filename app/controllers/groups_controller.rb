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

    amount = @group.maximum_amount # 上限金額
    n = @group.food_ids.size # 数量

    # 値段とカロリーの配列を作成
    price_calorie = Array.new(n) { [] }

    @group.food_ids.each_with_index do |id, i|
      price_calorie[i] << Food.find(id).price
      price_calorie[i] << Food.find(id).calorie
    end

    dp = Array.new(n + 1) { Array.new(amount + 1, 0) } # ここと
    selection = Array.new(n + 1) { Array.new(amount + 1, '') } # ここのコードが負荷やばそう

    price_calorie.each_with_index do |(price, calorie), i|
      (0..amount).each do |j|
        dp[i + 1][j] = dp[i][j]
        selection[i + 1][j] = "#{selection[i][j]}0"
        if j - price >= 0 && (dp[i + 1][j] < dp[i][j - price] + calorie)
          dp[i + 1][j] = dp[i][j - price] + calorie
          selection[i + 1][j] = "#{selection[i][j - price]}1"
        end
      end
    end

    answer = []

    (0..n - 1).each do |i|
      if selection[-1][-1].split('')[i] == '1'
        answer << @group.food_ids[i]
      end
    end

    @group.food_ids = answer

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
