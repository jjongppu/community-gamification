# frozen_string_literal: true
class CommunityAddExcludedGroupsToLeaderboards < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:gamification_leaderboards, :excluded_groups_ids)
      add_column :gamification_leaderboards,
                 :excluded_groups_ids,
                 :integer,
                 array: true,
                 null: false,
                 default: []
    end
  end
end
