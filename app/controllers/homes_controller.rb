class HomesController < ApplicationController
  skip_before_action :require_login, only: %i[index service privacy]
  def index; end

  def service; end

  def privacy; end
end
