class Mypage::CalendarsController < Mypage::BaseController
  def show
    @week_total_calories = current_user.groups.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).joins(:foods).sum(:calorie)
    @chart_data = current_user.groups.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).group("DATE_FORMAT(groups.created_at, '%m-%d')").joins(:foods).sum(:calorie)

    @week_chart = {}
    (Time.zone.now.beginning_of_week.to_date..Time.zone.now.end_of_week.to_date).step(1) do |date|
      @week_chart[date.strftime('%m-%d')] = @chart_data[date.strftime('%m-%d')] || 0
    end

    @user = User.find(current_user.id)
  end
end
