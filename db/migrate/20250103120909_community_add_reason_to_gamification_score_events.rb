# frozen_string_literal: true

class CommunityAddReasonToGamificationScoreEvents < ActiveRecord::Migration[7.0]
  def up
    # 1. Add the column as nullable with a default empty string
    add_column :gamification_score_events, :reason, :string, default: "", null: true

    # 2. Populate existing rows with the empty string
    execute <<~SQL
      UPDATE gamification_score_events
      SET reason = ''
      WHERE reason IS NULL
    SQL

    # 3. Enforce NOT NULL constraint once the table is backfilled
    change_column_null :gamification_score_events, :reason, false
  end

  def down
    remove_column :gamification_score_events, :reason
  end
end
