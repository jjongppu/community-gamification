class CommunityAddRelatedFieldsToGamificationScoreEvents < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:gamification_score_events, :related_id)
      add_column :gamification_score_events, :related_id, :text
    end
    unless column_exists?(:gamification_score_events, :related_type)
      add_column :gamification_score_events, :related_type, :text
    end
  end
end
