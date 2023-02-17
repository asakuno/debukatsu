class Food < ApplicationRecord
  include ImageUploader[:image]

  belongs_to :user
  has_many :select_foods, dependent: :destroy
  has_many :groups, through: :select_foods

  acts_as_taggable

  validates :food_name, presence: true
  validates :calorie, presence: true
  validates :protein, numericality: { allow_nil: true }
  validates :lipid, numericality: { allow_nil: true }
  validates :sugar, numericality: { allow_nil: true }
  validates :dietary_fiber, numericality: { allow_nil: true }
  validates :table_salt, numericality: { allow_nil: true }
end
