class TestWorker
  include Sidekiq::Worker

  def perform(args)
    mission = Mission.find(args.fetch('mission_id'))
    puts "YOOOOOOOO!!! #{mission.description}"
  end
end
