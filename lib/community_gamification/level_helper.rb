# frozen_string_literal: true

module CommunityGamification
  class LevelHelper

    def self.progress_for(user_id)
      score = GamificationScore.find_by(user_id: user_id)&.score || 0

      level_info = GamificationLevelInfo
        .where("min_score <= :score AND max_score >= :score", score: score)
        .first

      return {
        level: nil,
        progress_percent: 0,
        current_score: score,
        min: 0,
        max: 0,
        name: nil,
        image_url: nil
      } unless level_info

      min = level_info.min_score
      max = level_info.max_score
      progress = ((score - min).to_f / (max - min) * 100).round

      {
        level: level_info.level,
        progress_percent: progress,
        current_score: score,
        min: min,
        max: max,
        name: level_info.name,
        image_url: level_info.image_url
      }
    end
  end
end
