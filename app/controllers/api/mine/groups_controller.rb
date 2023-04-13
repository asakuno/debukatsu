class Api::Mine::GroupsController < ApplicationController
  def index
    @groups = current_user.groups
    #render json: @groups.to_json(only: [:id, :group_name, :created_at])
  end
end