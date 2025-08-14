# frozen_string_literal: true

class CommunityAddPointToGamificationScores < ActiveRecord::Migration[7.0]
  def up
    add_column :gamification_scores, :point, :integer, null: false, default: 0 unless column_exists?(:gamification_scores, :point)
    execute("UPDATE gamification_scores SET point = score") if column_exists?(:gamification_scores, :point)
  end

  def down
    remove_column :gamification_scores, :point if column_exists?(:gamification_scores, :point)
  end
end
