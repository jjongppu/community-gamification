# frozen_string_literal: true

module Jobs
  class RefreshLeaderboardPositions < ::Jobs::Base
    def execute(args)
      leaderboard_id = args[:leaderboard_id]
      raise Discourse::InvalidParameters.new(:leaderboard_id) if leaderboard_id.blank?

      leaderboard = CommunityGamification::GamificationLeaderboard.find_by(id: leaderboard_id)
      return unless leaderboard

      CommunityGamification::LeaderboardCachedView.new(leaderboard).refresh
    end
  end
end
