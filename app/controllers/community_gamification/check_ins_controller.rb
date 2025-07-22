# frozen_string_literal: true

class CommunityGamification::CheckInsController < ApplicationController
  requires_plugin CommunityGamification::PLUGIN_NAME
  before_action :ensure_logged_in

  def create
    result = CommunityGamification::CheckInRecorder.new(current_user).call
    render json: result
  end
end
