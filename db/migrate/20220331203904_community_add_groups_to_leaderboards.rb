# frozen_string_literal: true
class CommunityAddGroupsToLeaderboards < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:gamification_leaderboards, :visible_to_groups_ids)
      add_column :gamification_leaderboards,
                 :visible_to_groups_ids,
                 :integer,
                 array: true,
                 null: false,
                 default: []
    end

    unless column_exists?(:gamification_leaderboards, :included_groups_ids)
      add_column :gamification_leaderboards,
                 :included_groups_ids,
                 :integer,
                 array: true,
                 null: false,
                 default: []
    end
  end
end
