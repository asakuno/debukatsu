class ProfileForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :age, :integer
  attribute :gender, :integer
  attribute :weight, :integer
  attribute :user_id, :integer
  attribute :profile_id, :integer
  attribute :momentum, :integer

  validates :profile_id, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  validates :weight, presence: true
  validates :momentum, presence: true

  def save
    profile = Profile.create(momentum: momentum, user_id: current_user.id)
    User.create(age: age, gender: gender, weight: weight, profile_id: profile.id)
  end
end