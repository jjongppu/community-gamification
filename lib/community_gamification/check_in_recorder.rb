module CommunityGamification
  class CheckInRecorder
    def initialize(user)
      @user = user
    end

    def call
      today = Date.current

      if SiteSetting.score_day_visited_enabled
        record_day_visit(today)
      else
        record_first_login(today)
      end
    end

    private

    def record_day_visit(today)
      reason = SiteSetting.day_visited_score_reason
      weekend = today.saturday? || today.sunday?
      points = weekend ? SiteSetting.day_visited_weekend_score_value : SiteSetting.day_visited_score_value
      description = weekend ? "주말출석" : "출석"

      existing = GamificationScoreEvent.find_by(
        user_id: @user.id,
        date: today,
        reason: reason,
      )

      if existing
        { points_awarded: false, points: 0 }
      else
        event = GamificationScoreEvent.record!(
          user_id: @user.id,
          date: today,
          points: points,
          reason: reason,
          description: description,
        )
        { points_awarded: true, points: event.points }
      end
    end

    def record_first_login(today)
      before_count = GamificationScoreEvent.where(
        user_id: @user.id,
        date: today,
        reason: FirstLoginRewarder::REASON,
      ).count

      FirstLoginRewarder.new(@user).call

      after_count = GamificationScoreEvent.where(
        user_id: @user.id,
        date: today,
        reason: FirstLoginRewarder::REASON,
      ).count

      awarded = after_count > before_count
      points = if awarded
        today.saturday? || today.sunday? ? SiteSetting.day_visited_weekend_score_value : SiteSetting.day_visited_score_value
      else
        0
      end
      { points_awarded: awarded, points: points }
    end
  end
end
