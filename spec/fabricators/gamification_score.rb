# frozen_string_literal: true

Fabricator(:gamification_score, from: ::CommunityGamification::GamificationScore) do
  user_id { Fabricate(:user).id }
  score { 0 }
  date { Date.today }
end
