class MissionsController < ApplicationController
  def index
    all_missions = Mission
      .all
      .reduce([]) do |accum, mission|
        if mission.status.description != 'complete'
          accum.push({
            id: mission.id,
            description: mission.description,
            category_id: mission
              .mission_categories
              .first
              .id,
            due_date: mission
              .mission_due_dates
              .order(:due_date)
              .last
              .due_date,
            status: mission
              .status
              .description,
          })
        end
        accum
      end

    render json: { data: all_missions }
  end

  def create
    new_mission = Mission.create!(mission_params)
    new_mission_id = new_mission.id

    mission_due_date = MissionDueDate.create!(
      option: due_date_params[:option],
      due_date: DateTime.parse(due_date_params[:datetime]),
      mission_id: new_mission_id
    )
    due_date = mission_due_date.due_date

    mission_category = MissionCategory.create!(
      mission_id: new_mission_id,
      category_id: category_params[:category_id]
    )

    mission_status = MissionStatus.create!(
      mission_id: new_mission_id,
      description: 'standby'
    )

    notify_at_datetimes = GenerateNotificationTimes.new(
      due_date: due_date
    ).generate

    notify_at_datetimes.each do |notify_at_datetime|
      # these are active support timewithzone so difference is in seconds
      day_left_float = (due_date - notify_at_datetime) / 1.day
      hours_left = (day_left_float * 24).to_i
      display_time = hours_left < 24 ?
        "#{hours_left} #{'hour'.pluralize(hours_left)}" :
        "#{day_left_float.to_i} #{'day'.pluralize(day_left_float.to_i)}"

      mission_notification = Notification.create!(
        mission_id: new_mission_id,
        title: 'YO From Mission Control',
        body: "Don't forget to #{new_mission.description}! You have #{display_time} left!",
        datetime: notify_at_datetime,
        status: 'scheduled'
      )

      notification_job_id = NotificationsWorker.perform_at(
        notify_at_datetime,
        notification_id: mission_notification.id
      )

      mission_notification.update(job_id: notification_job_id)
    end

    render json: {
      status: 'SUCCESS',
      data: {
        id: new_mission_id,
        description: new_mission.description,
        category_id: mission_category.category_id,
        due_date: due_date,
        status: mission_status.description,
      }
    }
  end

  def update_status
    MissionStatus.create!(
      mission_id: update_status_params[:mission_id],
      description: update_status_params[:status]
    )
    # add to complete action, get all IDs from backend
    # of remaining notifications and dismiss them

    render json: {
      status: 'SUCCESS'
    }
  end

  private
  def mission_params
    params.permit(:description)
  end

  def due_date_params
    params.require(:due_date).permit(:datetime, :option)
  end

  def category_params
    params.permit(:category_id)
  end

  def update_status_params
    params.permit(:mission_id, :status)
  end
end
