require "rails_helper"

RSpec.describe CommunityGamification::CheckInsController do
  fab!(:user)

  before { SiteSetting.community_gamification_enabled = true }

  it "awards points once per day" do
    sign_in(user)

    post "/gamification/check-in.json"
    expect(response.status).to eq(200)
    expect(response.parsed_body["points_awarded"]).to eq(true)

    post "/gamification/check-in.json"
    expect(response.parsed_body["points_awarded"]).to eq(false)
  end

  it "awards login points when daily visit disabled" do
    sign_in(user)
    SiteSetting.score_day_visited_enabled = false

    post "/gamification/check-in.json"
    expect(response.parsed_body["points_awarded"]).to eq(true)
    expect(CommunityGamification::GamificationScoreEvent.last.reason).to eq("first_login")

    post "/gamification/check-in.json"
    expect(response.parsed_body["points_awarded"]).to eq(false)
  end

  it "uses weekend score value" do
    sign_in(user)
    SiteSetting.day_visited_score_value = 10
    SiteSetting.day_visited_weekend_score_value = 20

    freeze_time Date.parse("2022-01-01") do
      post "/gamification/check-in.json"
      expect(response.parsed_body["points"]).to eq(20)
      expect(CommunityGamification::GamificationScoreEvent.last.description).to eq("주말출석")
    end

    freeze_time Date.parse("2022-01-03") do
      post "/gamification/check-in.json"
      expect(response.parsed_body["points"]).to eq(10)
      expect(CommunityGamification::GamificationScoreEvent.last.description).to eq("출석")
    end
  end
end
