class Api::FoodsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
    @foods = Food.includes(%i[taggings user groups]).references(:all)
  end
end