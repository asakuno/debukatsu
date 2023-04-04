class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :foods, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likes_foods, through: :likes, source: :food
  has_many :comments, dependent: :destroy
  has_one :profile

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :weight, presence: true

  enum role: { general: 0, guest: 1, admin: 2 }

  def own?(object)
    object.user_id == id
  end

  def self.guest_user_generate
    random_email = SecureRandom.hex(4)
    User.find_or_create_by!(name: 'Guest', email: "guest_#{random_email}@example.com") do |user|
      user.password = SecureRandom.alphanumeric(10)
      user.password_confirmation = user.password
      user.role = 1
    end
  end

  def like(food)
    likes_foods << food
  end

  def unlike(food)
    likes_foods.destroy(food)
  end

  def like?(food)
    likes_foods.include?(food)
  end
end
