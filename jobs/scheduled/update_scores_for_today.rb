# frozen_string_literal: true

module Jobs
  class UpdateScoresForToday < ::Jobs::Scheduled
    every 1.hour

    def execute(args = nil)
      CommunityGamification::GamificationScore.calculate_scores

      CommunityGamification::LeaderboardCachedView.purge_all_stale
      CommunityGamification::LeaderboardCachedView.refresh_all
      CommunityGamification::LeaderboardCachedView.create_all
    end
  end
end
