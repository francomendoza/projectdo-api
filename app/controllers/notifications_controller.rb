class NotificationsController < ApplicationController
  def update
    notification = Notification.find(notification_update_params[:notification_id])
    if notification.present?
      notification.update!(
        status: notification_update_params[:status],
        acknowledged_at: notification_update_params[:acknowledged_at],
      )
    end

    render json: {
      status: 'SUCCESS'
    }
  end

  private
  def notification_update_params
    params.permit(:notification_id, :status, :acknowledged_at)
  end
end
