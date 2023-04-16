class Profile < ApplicationRecord
  belongs_to :user

  validates :momentum, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
