namespace :notifications do
  desc 'add notitications to all uncompleted missions'
  task update: [:environment] do |t|
    now = DateTime.now.beginning_of_minute
    uncompleted_missions = Mission
      .all
      .each do |mission|
        mission_due_date = mission.mission_due_dates.first.due_date
        if mission.status.description != 'complete' &&
            mission_due_date && mission_due_date > now &&
            mission.notifications.empty?
            
          puts "Adding notifications to #{mission.description}"
          notify_at_datetimes = GenerateNotificationTimes
            .new(due_date: mission_due_date)
            .generate

          notify_at_datetimes.each do |notify_at_datetime|
            # these are active support timewithzone so difference is in seconds
            day_left_float = (mission_due_date - notify_at_datetime) / 1.day
            hours_left = (day_left_float * 24).to_i
            display_time = hours_left < 24 ?
              "#{hours_left} #{'hour'.pluralize(hours_left)}" :
              "#{day_left_float.to_i} #{'day'.pluralize(day_left_float.to_i)}"

            mission_notification = Notification.create!(
              mission_id: mission.id,
              title: 'YO From Mission Control',
              body: "Don't forget to #{mission.description}! You have #{display_time} left!",
              datetime: notify_at_datetime,
              status: 'scheduled'
            )

            notification_job_id = NotificationsWorker.perform_at(
              notify_at_datetime,
              notification_id: mission_notification.id
            )

            mission_notification.update(job_id: notification_job_id)
          end
        end
      end

  end
end
