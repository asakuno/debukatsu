class Food < ApplicationRecord
  belongs_to :user
  has_many :select_foods, dependent: :destroy
  has_many :groups, through: :select_foods

  validates :food_name, presence: true
  validates :calorie, presence: true
end
