class CommunityAddRelatedFieldsToGamificationScoreEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :gamification_score_events, :related_id, :text
    add_column :gamification_score_events, :related_type, :text
  end
end
