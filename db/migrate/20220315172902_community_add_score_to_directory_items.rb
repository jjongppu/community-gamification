# frozen_string_literal: true
class CommunityAddScoreToDirectoryItems < ActiveRecord::Migration[6.1]
  def up
    unless column_exists?(:directory_items, :gamification_score)
      add_column :directory_items, :gamification_score, :integer, default: 0
    end
  end

  def down
    remove_column :directory_items, :gamification_score if column_exists?(:directory_items, :gamification_score)
  end
end
