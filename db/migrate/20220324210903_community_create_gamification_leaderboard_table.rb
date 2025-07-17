# frozen_string_literal: true
class CommunityCreateGamificationLeaderboardTable < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:gamification_leaderboards)
      create_table :gamification_leaderboards do |t|
        t.string :name, null: false
        t.date :from_date, null: true
        t.date :to_date, null: true
        t.integer :for_category_id, null: true
        t.integer :created_by_id, null: false
        t.timestamps
      end
    end

    add_index :gamification_leaderboards, [:name], unique: true unless index_exists?(:gamification_leaderboards, [:name])
  end
end
