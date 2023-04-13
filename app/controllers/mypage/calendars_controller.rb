class Mypage::CalendarsController < Mypage::BaseController
  def show
    @weak_total_calories = current_user.groups.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).joins(:foods).sum(:calorie)
  end
end
