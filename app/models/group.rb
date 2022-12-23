class Group < ApplicationRecord
  belongs_to :user
  has_many :select_foods, dependent: :destroy
  has_many :foods, through: :select_foods

  validates :group_name, presence: true
  validates :maximum_amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than_or_equal_to: 5000000}
end
