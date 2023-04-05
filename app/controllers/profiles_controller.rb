require_relative '../forms/profile_form'
class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def new
    @profile = ProfileForm.new
  end

  def create
    @profile = Profile.new(profile_params)
  
    if @profile.save
      redirect_to @profile
    else
      render :new
    end
  end

  def show
  end

  def edit
    @user.build_profile if @user.profile.nil?
  end

  def update
    if @user.update(profile_params)
      redirect_to root_path, notice: 'ユーザー情報を更新しました'
    else
      render :edit
    end
  end

  private
  
  def set_user
    @user = User.find(current_user.id)
  end

  def profile_params
    params.require(:user).permit(:name, :age, :gender, :weight,
                                 profile_attributes: [:id, :momentum])
  end
end
