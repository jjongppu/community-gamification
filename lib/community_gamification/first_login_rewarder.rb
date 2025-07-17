module CommunityGamification
  class FirstLoginRewarder
    DESCRIPTION = "first_login"

    def initialize(user)
      @user = user
    end

    def call
      return unless SiteSetting.community_gamification_enabled
      return if SiteSetting.score_day_visited_enabled

      today = Date.current
      return if GamificationScoreEvent.exists?(user_id: @user.id, date: today, description: DESCRIPTION)

      weekend = today.saturday? || today.sunday?
      points = if weekend
        SiteSetting.day_visited_weekend_score_value
      else
        SiteSetting.day_visited_score_value
      end

      GamificationScoreEvent.create!(
        user_id: @user.id,
        date: today,
        points: points,
        description: DESCRIPTION,
        reason: DESCRIPTION,
      )
    end
  end
end
