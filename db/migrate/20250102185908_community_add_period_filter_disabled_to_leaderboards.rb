# frozen_string_literal: true

class CommunityAddPeriodFilterDisabledToLeaderboards < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:gamification_leaderboards, :period_filter_disabled)
      add_column :gamification_leaderboards,
                 :period_filter_disabled,
                 :boolean,
                 default: false,
                 null: false
    end
  end
end
