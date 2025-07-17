# frozen_string_literal: true

module Jobs
  class UpdateStaleLeaderboardPositions < ::Jobs::Base
    def execute(args = nil)
      CommunityGamification::LeaderboardCachedView.update_all
    end
  end
end
