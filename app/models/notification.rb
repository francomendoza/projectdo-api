class Notification < ApplicationRecord
  belongs_to :mission

  def destroy
    # destroy Sidekiq job
    super
  end
end
