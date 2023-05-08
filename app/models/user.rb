class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_foods, through: :likes, source: :food
  has_many :comments, dependent: :destroy
  has_one :profile
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :authentications

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

  def target_calories
    profile.momentum * 240 + required_calories
  end

  def required_calories
    calorie_table = {
      school_child: {
        low: {
          unanswered: 1900,
          male: 1950,
          female: 1850
        },
        midle: {
          unanswered: 2175,
          male: 2250,
          female: 2100
        },
        high: {
          unanswered: 2425,
          male: 2500,
          female: 2350
        }
      },
      teenager: {
        low: {
          unanswered: 2000,
          male: 2300,
          female: 1700
        },
        midle: {
          unanswered: 2325,
          male: 2650,
          female: 2000
        },
        high: {
          unanswered: 2675,
          male: 3050,
          female: 2300
        }
      },
      young_adult: {
        low: {
          unanswered: 2025,
          male: 2300,
          female: 1750
        },
        midle: {
          unanswered: 2375,
          male: 2700,
          female: 2050
        },
        high: {
          unanswered: 2700,
          male: 3050,
          female: 2350
        }
      },
      middle_adulthood: {
        low: {
          unanswered: 1925,
          male: 2200,
          female: 1650
        },
        midle: {
          unanswered: 2280,
          male: 2600,
          female: 1960
        },
        high: {
          unanswered: 2600,
          male: 2950,
          female: 2250
        }
      },
      young_old: {
        low: {
          unanswered: 1800,
          male: 2050,
          female: 1550
        },
        midle: {
          unanswered: 2125,
          male: 2400,
          female: 1850
        },
        high: {
          unanswered: 2425,
          male: 2750,
          female: 2100
        }
      }
    }
    calorie_table[age.to_sym][weight.to_sym][gender.to_sym]
  end
end
