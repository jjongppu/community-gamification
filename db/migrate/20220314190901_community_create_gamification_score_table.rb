# frozen_string_literal: true
class CommunityCreateGamificationScoreTable < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:gamification_scores)
      create_table :gamification_scores do |t|
        t.integer :user_id, null: false
        t.date :date, null: false
        t.integer :score, null: false
      end
    end

    unless index_exists?(:gamification_scores, %i[user_id date])
      add_index :gamification_scores, %i[user_id date], unique: true
    end

    add_index :gamification_scores, :date unless index_exists?(:gamification_scores, :date)
  end
end
