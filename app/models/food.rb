class Food < ApplicationRecord
  include ImageUploader[:image]

  belongs_to :user
  has_many :select_foods, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :groups, through: :select_foods

  acts_as_taggable

  validates :food_name, presence: true
  validates :calorie, presence: true
  validates :protein, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }
  validates :lipid, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }
  validates :sugar, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }
  validates :dietary_fiber, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }
  validates :table_salt, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    %w[food_name calorie price]
  end
end
