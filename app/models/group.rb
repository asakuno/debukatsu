class Group < ApplicationRecord
  belongs_to :user
  has_many :select_foods, dependent: :destroy
  has_many :foods, through: :select_foods
  has_many :comments, dependent: :destroy

  validates :group_name, presence: true
  validates :maximum_amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 30_000 }
  validates :publish, inclusion: { in: [true, false] }

  # 長すぎるとrubocopに指摘された[<17, 61, 10> 64.11/25]
  def high_calorie(maximum_amount, food_ids)
    # 食べ物の数量
    quantity = food_ids.size
    # 値段とカロリーを紐付けた配列を作成
    price_calorie = Array.new(quantity) { [] }

    food_ids.each_with_index do |id, i|
      price_calorie[i] << Food.find(id).price
      price_calorie[i] << Food.find(id).calorie
    end

    # dpと選んだ食べ物を記憶する配列を作成
    dp = Array.new(quantity + 1) { Array.new(maximum_amount + 1, 0) }
    selection = Array.new(quantity + 1) { Array.new(maximum_amount + 1, '') }

    # dp
    price_calorie.each_with_index do |(price, calorie), i|
      (0..maximum_amount).each do |j|
        # 商品i+1を選ばない場合
        # 前のカロリーと同じ
        dp[i + 1][j] = dp[i][j]
        # 何もないので0を入れる
        selection[i + 1][j] = "#{selection[i][j]}0"
        # 上限金額を金額が下回る場合と、選んだ場合のカロリーの合計が既存の最大値よりも大きくならない場合
        next unless j - price >= 0 && (dp[i + 1][j] < dp[i][j - price] + calorie)

        # 商品i+1を選ぶ場合
        # 前のカロリーに選んだカロリーを加える
        dp[i + 1][j] = dp[i][j - price] + calorie
        # 商品を選んだので1を入れる
        selection[i + 1][j] = "#{selection[i][j - price]}1"
      end
    end

    # 選んだ食べ物のidを入れる配列を作成
    @best_foods = []

    (0..quantity - 1).each do |i|
      # 選んだ商品がある（１）状態で配列に入れる
      if selection[-1][-1].split('')[i] == '1'
        @best_foods << food_ids[i]
      end
    end
    self.food_ids = @best_foods
  end
end
