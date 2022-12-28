class HomesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    GroupJob.perform_later
  end
end
