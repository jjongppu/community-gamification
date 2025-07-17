# frozen_string_literal: true

class CommunityCreateGamificationScoreEvents < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:gamification_score_events)
      create_table :gamification_score_events do |t|
        t.integer :user_id, null: false
        t.date :date, null: false
        t.integer :points, null: false
        t.text :description, null: true

        t.timestamps
      end
    end

    unless index_exists?(:gamification_score_events, %i[user_id date])
      add_index :gamification_score_events, %i[user_id date], unique: false
    end
    add_index :gamification_score_events, %i[date], unique: false unless index_exists?(:gamification_score_events, %i[date])
  end
end
