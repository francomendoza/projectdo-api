class DueDateOptionConverter
  def convert(option)
    case option
    when 'EOD'
      now.end_of_day
    when 'EOWeek'
      # if its saturday, end of week should apply to next friday
      if now.wday == 6
        (now + 1.day).end_of_week - 2.days
      else
        now.end_of_week - 2.days
      end
    when 'EOWeekend'
      # if sunday, end of weekend should apply to next sunday
      if now.wday == 0
        (now + 1.day).end_of_week
      else
        now.end_of_week
      end
    when 'EOMonth'
      now.end_of_month
    when 'EOYear'
      now.end_of_year
    when 'Eventually'
      nil
    end
  end

  private
  def now
    @now ||= Time.now.beginning_of_minute
  end
end
