class Notification < ApplicationRecord
  belongs_to :mission

  def destroy
    # destroy Sidekiq job
    if self.job_id
      job = Sidekiq::ScheduledSet.new.find_job(self.job_id)
      if job
        job.delete
      else
        raise 'Associated job not found, did not delete '
      end
    end
    super
  end
end
