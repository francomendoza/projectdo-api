class Notification < ApplicationRecord
  belongs_to :mission

  def destroy
    # destroy Sidekiq job
    job = Sidekiq::ScheduledSet.new.find_job(self.job_id)
    if job
      job.delete
    else
      raise 'Associated job not found, did not delete '
    end
    super
  end
end
