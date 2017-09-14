class NotificationsController < ApplicationController
  def create
    Notification.create!(
      datetime: notification_params[:notification_datetime],
      client: 'expo-ios',
      local_notification_id: notification_params[:local_notification_id],
      mission_id: notification_params[:mission_id],
      status: 'scheduled',
    )
    render json: {
      status: 'SUCCESS'
    }
  end

  private
  def notification_params
    params.permit(:notification_datetime, :local_notification_id, :mission_id)
  end
end
