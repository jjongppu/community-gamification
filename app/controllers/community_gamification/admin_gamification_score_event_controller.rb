# frozen_string_literal: true

class CommunityGamification::AdminGamificationScoreEventController < Admin::AdminController
  requires_plugin CommunityGamification::PLUGIN_NAME

  def show
    params.permit(%i[id user_id date])

    events = CommunityGamification::GamificationScoreEvent.limit(100)
    events = events.where(id: params[:id]) if params[:id]
    events = events.where(user_id: params[:user_id]) if params[:user_id]
    events = events.where(date: params[:date]) if params[:date]

    raise Discourse::NotFound unless events

    render_serialized({ events: events }, AdminGamificationScoreEventIndexSerializer, root: false)
  end

  def create
    params.require(%i[user_id date points reason])
    params.permit(:description, :related_id, :related_type)

    event = CommunityGamification::GamificationScoreEvent.record!(
      user_id: params[:user_id],
      date: params[:date],
      points: params[:points],
      reason: params[:reason],
      description: params[:description],
      related_id: params[:related_id],
      related_type: params[:related_type],
    )

    render_serialized(event, AdminGamificationScoreEventSerializer, root: false)
  end

  def update
    params.require(%i[id points reason])
    params.permit(:description, :related_id, :related_type)

    event = CommunityGamification::GamificationScoreEvent.find(params[:id])
    raise Discourse::NotFound unless event

    if event.update(points: params[:points],
                    reason: params[:reason],
                    description: params[:description] || event.description,
                    related_id: params[:related_id],
                    related_type: params[:related_type])
      render json: success_json
    else
      render_json_error(event)
    end
  end
end
