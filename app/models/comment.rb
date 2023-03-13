class Comment < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :body, presence: :true, length: { maximum: 100 }
end
