class SelectFood < ApplicationRecord
  belongs_to :food
  belongs_to :group

  validates :group_id, uniqueness: { scope: :food_id }
end
