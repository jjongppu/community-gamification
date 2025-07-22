require "rails_helper"

RSpec.describe "Login check-in via Warden callback" do
  fab!(:user)

  before { SiteSetting.community_gamification_enabled = true }

  it "awards points only once per day on login" do
    SiteSetting.score_day_visited_enabled = false
    SiteSetting.day_visited_score_value = 5

    sign_in(user)

    event_count = CommunityGamification::GamificationScoreEvent.where(
      user_id: user.id,
      date: Date.current,
      reason: CommunityGamification::FirstLoginRewarder::REASON,
    ).count
    expect(event_count).to eq(1)

    sign_in(user)

    event_count = CommunityGamification::GamificationScoreEvent.where(
      user_id: user.id,
      date: Date.current,
      reason: CommunityGamification::FirstLoginRewarder::REASON,
    ).count
    expect(event_count).to eq(1)
  end
end
