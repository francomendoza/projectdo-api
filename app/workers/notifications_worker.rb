class NotificationsWorker
  include Sidekiq::Worker

  def perform(args)
    # Ping expo push notifications server
    notification = Notification.find(args.fetch('notification_id'))
    exponent.publish(
      [
        {
          to: push_token,
          title: notification.title,
          body: notification.body,
          data: {
            notification_id: notification.id
          }
        }
      ]
    )
  end

  private
  def exponent
    @exponent ||= Exponent::Push::Client.new
  end

  def push_token
    # eventually will be associated to user
    @push_token ||= PushToken.first.value
  end
end
