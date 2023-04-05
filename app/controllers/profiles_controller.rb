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
    @profileform = ProfileForm.new(User.find(current_user.id))
  end

  def update
  end

  private
  
  def set_user
    @user = User.find(current_user.id)
  end
end
