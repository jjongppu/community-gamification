# frozen_string_literal: true

return if Rails.env.test? || CommunityGamification::GamificationLeaderboard.any?

CommunityGamification::GamificationLeaderboard.seed(:name) do |leaderboard|
  leaderboard.name = I18n.t("default_leaderboard_name")
  leaderboard.created_by_id = Discourse.system_user.id
end
