# frozen_string_literal: true

module CommunityGamification
  module UserLevelSerializerExtension
    def self.register!
      ::UserCardSerializer.class_eval do
        attributes :gamification_level_info, :user_level_image_url

        def gamification_level_info
          return nil unless object&.id
          CommunityGamification::LevelHelper.progress_for(object.id)
        rescue => e
          Rails.logger.error("Gamification Level Error: #{e.message}")
          nil
        end

        def user_level_image_url
          return nil unless object&.id
          info = CommunityGamification::LevelHelper.progress_for(object.id)
          info[:image_url] if info
        rescue => e
          Rails.logger.error("Gamification Level Image Error: #{e.message}")
          nil
        end
      end

      ::PostSerializer.class_eval do
        attributes :gamification_level_info, :user_level_image_url

        def gamification_level_info
          return nil unless object&.user_id
          CommunityGamification::LevelHelper.progress_for(object.user_id)
        rescue => e
          Rails.logger.error("Gamification Level Error: #{e.message}")
          nil
        end

        def user_level_image_url
          return nil unless object&.user_id
          info = CommunityGamification::LevelHelper.progress_for(object.user_id)
          info[:image_url] if info
        rescue => e
          Rails.logger.error("Gamification Level Image Error: #{e.message}")
          nil
        end
      end
    end
  end
end
