class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :foods, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_foods, through: :likes, source: :food
  has_many :comments, dependent: :destroy
  has_one :profile
  accepts_nested_attributes_for :profile

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true

  enum role: { general: 0, guest: 1, admin: 2 }
  enum gender: { unanswered: 0, male: 1, female: 2 }
  enum age: { school_child: 0, teenager: 1, young_adult: 2, middle_adulthood: 3, young_old: 4 }
  enum weight: { low: 0, midle: 1, high: 2 }

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
    like_foods << food
  end

  def unlike(food)
    like_foods.destroy(food)
  end

  def like?(food)
    food.likes.pluck(:user_id).include?(id)
  end

  def profile_complete?
    age.present? && gender.present? && weight.present?
  end
end
