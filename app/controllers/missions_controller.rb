class MissionsController < ApplicationController
  def index
    all_missions = Mission.all.map do |mission|
      {
        id: mission.id,
        description: mission.description,
        category_id: mission.mission_categories.first.id,
        due_date: mission.mission_due_dates.order(:due_date).last.due_date,
        status: mission.mission_statuses.order(:created_at).last.description,
      }
    end

    render json: { data: all_missions }
  end

  def create
    new_mission = Mission.create!(mission_params)

    mission_due_date = MissionDueDate.create!(
      due_date_params.merge({
        due_date: DueDateOptionConverter.new.convert(due_date_params[:option]),
        mission_id: new_mission.id
      })
    )

    mission_category = MissionCategory.create!(
      mission_id: new_mission.id,
      category_id: category_params[:category_id]
    )

    mission_status = MissionStatus.create!(
      mission_id: new_mission.id,
      description: 'standby'
    )

    render json: {
      status: 'SUCCESS',
      data: {
        id: new_mission.id,
        description: new_mission.description,
        category_id: mission_category.category_id,
        due_date: mission_due_date.due_date,
        status: mission_status.description,
      }
    }
  end

  def update_status
    MissionStatus.create!(
      mission_id: update_status_params[:mission_id],
      description: update_status_params[:status]
    )

    render json: {
      status: 'SUCCESS'
    }
  end

  private
  def mission_params
    params.permit(:description)
  end

  def due_date_params
    params.permit(:option)
  end

  def category_params
    params.permit(:category_id)
  end

  def update_status_params
    params.permit(:mission_id, :status)
  end
end
