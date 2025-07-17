# frozen_string_literal: true

module ::CommunityGamification
  class DayVisited < Scorable
    def self.score_multiplier
      SiteSetting.day_visited_score_value
    end

    def self.weekend_score_multiplier
      SiteSetting.day_visited_weekend_score_value
    end

    def self.query
      <<~SQL
        SELECT
          uv.user_id AS user_id,
          date_trunc('day', uv.visited_at) AS date,
          SUM(
            CASE
              WHEN EXTRACT(DOW FROM uv.visited_at) IN (0, 6)
                THEN #{weekend_score_multiplier}
              ELSE #{score_multiplier}
            END
          ) AS points
        FROM
          user_visits AS uv
        WHERE
          uv.visited_at >= :since
        GROUP BY
          1, 2
      SQL
    end
  end
end
