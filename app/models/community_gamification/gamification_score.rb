# frozen_string_literal: true

module ::CommunityGamification
  class GamificationScore < ::ActiveRecord::Base
    self.table_name = "gamification_scores"

    belongs_to :user

    def self.enabled_scorables
      Scorable.subclasses.filter { _1.enabled? }
    end

    def self.scorables_queries
      enabled_scorables.map { "( #{_1.query} )" }.join(" UNION ALL ")
    end

    def self.adjust_score(user_id:, points:)
      DB.exec(<<~SQL, user_id: user_id, points: points)
        INSERT INTO gamification_scores (user_id, score, point, date)
        VALUES (:user_id, :points, :points, CURRENT_DATE)
        ON CONFLICT (user_id) DO UPDATE
        SET score = gamification_scores.score + EXCLUDED.score,
            point = gamification_scores.point + EXCLUDED.point;
      SQL

      LeaderboardCachedView.refresh_all
    end

    def self.calculate_scores(since_date: Date.today, only_subclass: nil)
      queries = only_subclass&.query || scorables_queries

      DB.exec(<<~SQL, since: since_date)
        DELETE FROM gamification_scores;

        INSERT INTO gamification_scores (user_id, score, point, date)
        SELECT user_id, SUM(points) AS score, SUM(points) AS point, CURRENT_DATE
        FROM (
          #{queries}
          UNION ALL
          SELECT user_id, SUM(points) AS points
          FROM gamification_score_events
          GROUP BY 1
        ) AS source
        WHERE user_id IS NOT NULL
        GROUP BY 1
        ON CONFLICT (user_id) DO UPDATE
        SET score = EXCLUDED.score,
            point = EXCLUDED.point;
      SQL
    end

    def self.merge_scores(source_user, target_user)
      DB.exec(<<~SQL, source_id: source_user.id, target_id: target_user.id)
        WITH new_scores AS (
          SELECT :target_id AS user_id, SUM(score) AS score, SUM(point) AS point
          FROM gamification_scores
          WHERE user_id IN (:source_id, :target_id)
          GROUP BY 1
        ) INSERT INTO gamification_scores (user_id, score, point, date)
          SELECT user_id, score AS score, point, CURRENT_DATE
          FROM new_scores
          ON CONFLICT (user_id) DO UPDATE
          SET score = EXCLUDED.score,
              point = EXCLUDED.point;
      SQL

      DB.exec(<<~SQL, source_id: source_user.id)
        DELETE FROM gamification_scores
        WHERE user_id = :source_id;
      SQL
    end
  end
end

# == Schema Information
#
# Table name: gamification_scores
#
#  id      :bigint           not null, primary key
#  user_id :integer          not null
#  date    :date             not null
#  score   :integer          not null
#  point   :integer          not null
#
# Indexes
#
#  index_gamification_scores_on_user_id  (user_id) UNIQUE
#
