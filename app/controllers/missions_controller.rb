class MissionsController < ApplicationController
  def index

  end

  def create
    byebug
    new_mission = Mission.create!(mission_params)

    MissionDueDate.create!(
      due_date_params.merge({
        due_date: DueDateOptionConverter.new.convert(due_date_params[:option]),
        mission_id: new_mission.id
      })
    )

    MissionCategory.create!(
      mission_id: new_mission.id,
      category_id: category_params[:category_id]
    )

    render json: { status: "SUCCESS" }
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
end
