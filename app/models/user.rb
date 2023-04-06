class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :foods, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likes_foods, through: :likes, source: :food
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
  enum gender: { female: 0, male: 1, unanswered: 2 }
  enum age: { child: 0, school_child: 1, teenager: 2, young_adult: 3, middle_adulthood: 4, young_middle_age_adult: 5, young_old: 6 }
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
    likes_foods << food
  end

  def unlike(food)
    likes_foods.destroy(food)
  end

  def like?(food)
    likes_foods.include?(food)
  end

  def profile_complete?
    age.present? && gender.present? && weight.present?
  end
end
