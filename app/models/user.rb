class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :foods, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true

  def own?(object)
    object.user_id == id
  end

  def self.guest_user_generate
    random_email = SecureRandom.hex(4)
    User.find_or_create_by!(name: 'Guest', email: 'guest_#{random_email}@example.com') do |user|
      user.password = SecureRandom.alphanumeric(10)
      user.password_confirmation = user.password
    end
  end
end
