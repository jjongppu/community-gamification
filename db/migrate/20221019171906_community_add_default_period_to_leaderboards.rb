# frozen_string_literal: true
class CommunityAddDefaultPeriodToLeaderboards < ActiveRecord::Migration[6.1]
  def up
    unless column_exists?(:gamification_leaderboards, :default_period)
      add_column :gamification_leaderboards, :default_period, :integer, default: 0
    end
  end

  def down
    remove_column :gamification_leaderboards, :default_period if column_exists?(:gamification_leaderboards, :default_period)
  end
end
