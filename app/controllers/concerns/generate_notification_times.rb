class GenerateNotificationTimes
  RANGE_MAP = [
    {
      description: 'day_of',
      range_start: 1,
      range_end: 3,
    },
    {
      description: 'day_of',
      range_start: 4,
      range_end: 6,
    },
    {
      description: 'day_of',
      range_start: 7,
      range_end: 9,
    },
    {
      description: 'day_of',
      range_start: 10,
      range_end: 12,
    },
    {
      description: 'day_of',
      range_start: 13,
      range_end: 16,
    },
    {
      description: 'one_day_before',
      range_start: 25,
      range_end: 30,
    },
    {
      description: 'one_day_before',
      range_start: 31,
      range_end: 35,
    },
    {
      description: 'one_day_before',
      range_start: 36,
      range_end: 39,
    },
    {
      description: 'week_before',
      range_start: 49, # 2 days before
      range_end: 63,
    },
    {
      description: 'week_before',
      range_start: 73, # 3 days before
      range_end: 87,
    },
    {
      description: 'week_before',
      range_start: 97, # 4 days before
      range_end: 111,
    },
    {
      description: 'week_before',
      range_start: 121, # 5 days before
      range_end: 135,
    },
    {
      description: 'week_before',
      range_start: 145, # 6 days before
      range_end: 159,
    },
    {
      description: 'week_before',
      range_start: 169, # 7 days before
      range_end: 183,
    },
    {
      description: 'two_weeks_before',
      range_start: 217, # 9 days before
      range_end: 231,
    },
    {
      description: 'two_weeks_before',
      range_start: 265, # 11 days before
      range_end: 279,
    },
    {
      description: 'two_weeks_before',
      range_start: 313, # 13 days before
      range_end: 327,
    },
    {
      description: 'month_before',
      range_start: 409, # 17 days before
      range_end: 423,
    },
    {
      description: 'month_before',
      range_start: 505, # 21 days before
      range_end: 519,
    },
    {
      description: 'month_before',
      range_start: 601, # 25 days before
      range_end: 615,
    },
    {
      description: 'month_before',
      range_start: 697, # 29 days before
      range_end: 711,
    },
    {
      description: '60_days_before',
      range_start: 697, # 36 days before
      range_end: 711,
    },
    {
      description: '60_days_before',
      range_start: 865, # 43 days before
      range_end: 879,
    },
    {
      description: '60_days_before',
      range_start: 1033, # 50 days before
      range_end: 1047,
    },
    {
      description: '60_days_before',
      range_start: 1201, # 57 days before
      range_end: 1215,
    },
    {
      description: 'greater_60_days_before',
      range_start: 1537, # 71 days before
      range_end: 1551,
    },
    {
      description: 'greater_60_days_before',
      range_start: 1873, # 85 days before
      range_end: 1887,
    },
    {
      description: 'greater_60_days_before',
      range_start: 2209, # 99 days before
      range_end: 2223,
    },
    {
      description: 'greater_60_days_before',
      range_start: 2545, # 113 days before
      range_end: 2559,
    },
    {
      description: 'greater_60_days_before',
      range_start: 2881, # 127 days before
      range_end: 2895,
    },
    {
      description: 'greater_60_days_before',
      range_start: 3217, # 141 days before
      range_end: 3231,
    },
  ]

  def initialize(args)
    @due_date = args.fetch(:due_date)
  end

  def generate
    RANGE_MAP.reduce([]) do |accum, notif_obj|
      if notif_obj[:range_end] < hours_between_now_and_due_date
        # sample some hour between range
        random_hour = (
          rand * (notif_obj[:range_end] - notif_obj[:range_start] + 1)
        ).floor + notif_obj[:range_start]
        notification_time = @due_date - random_hour.hours
        accum.push(notification_time)
      end
      accum
    end
  end

  private
  def now
    @now ||= DateTime.now.beginning_of_minute
  end

  def hours_between_now_and_due_date
    # consider eventually where due_date is null
    @hours_between_now_and_due_date ||= ((@due_date.to_datetime - now) * 24).to_i
  end
end
