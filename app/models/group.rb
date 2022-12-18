class Group < ApplicationRecord
  belongs_to :user
  has_many :foods, through: :select_foods

  validates :group_name, presence: true
end
