# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommunityGamification::FirstLoginRewarder do
  fab!(:user)

  before { SiteSetting.community_gamification_enabled = true }

  it 'uses day visited score values and records only once per day' do
    SiteSetting.score_day_visited_enabled = false
    SiteSetting.day_visited_score_value = 5
    SiteSetting.day_visited_weekend_score_value = 10

    freeze_time Date.parse('2022-01-03') do
      described_class.new(user).call

      event = CommunityGamification::GamificationScoreEvent.find_by(user_id: user.id, description: 'first_login')
      expect(event).to be_present
      expect(event.points).to eq(5)
      expect(CommunityGamification::GamificationScore.find_by(user_id: user.id).score).to eq(5)

      described_class.new(user).call
      expect(CommunityGamification::GamificationScoreEvent.where(user_id: user.id, description: 'first_login').count).to eq(1)
      expect(CommunityGamification::GamificationScore.find_by(user_id: user.id).score).to eq(5)
    end
  end

  it 'uses weekend score value on weekends' do
    SiteSetting.score_day_visited_enabled = false
    SiteSetting.day_visited_score_value = 5
    SiteSetting.day_visited_weekend_score_value = 10

    freeze_time Date.parse('2022-01-01') do
      described_class.new(user).call
      event = CommunityGamification::GamificationScoreEvent.find_by(user_id: user.id, description: 'first_login')
      expect(event.points).to eq(10)
    end
  end
end
