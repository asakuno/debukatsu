class HomesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index; end

  def service; end

  def privacy; end 
end
