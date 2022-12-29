class GroupJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(user_id, group_params)
    @group = Group.new(group_params)
    @group.user_id = user_id

    maximum_amount = @group.maximum_amount
    food_ids = @group.food_ids
    quantity = food_ids.size
    price_calorie = Array.new(quantity) { [] }

    food_ids.each_with_index do |id, i|
      price_calorie[i] << Food.find(id).price
      price_calorie[i] << Food.find(id).calorie
    end

    # if文で分岐させたほうがいいかも？
    dp = Array.new(quantity + 1) { Array.new(maximum_amount + 1, 0) }
    selection = Array.new(quantity + 1) { Array.new(maximum_amount + 1, '') }

    price_calorie.each_with_index do |(price, calorie), i|
      (0..maximum_amount).each do |j|
        # 商品i+1を選ばない場合
        dp[i + 1][j] = dp[i][j]
        selection[i + 1][j] = "#{selection[i][j]}0"
        next unless j - price >= 0 && (dp[i + 1][j] < dp[i][j - price] + calorie)

        # 商品i+1を選ぶ場合
        dp[i + 1][j] = dp[i][j - price] + calorie
        selection[i + 1][j] = "#{selection[i][j - price]}1"
      end
    end

    @best_foods = []

    (0..quantity - 1).each do |i|
      if selection[-1][-1].split('')[i] == '1'
        @best_foods << food_ids[i]
      end
    end
    @group.food_ids = @best_foods

    @group.save!(group_name: @group.group_name, maximum_amount: @group.maximum_amount, food_ids: @best_foods)
  end
end