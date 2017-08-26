class DueDateOptionConverter
  def convert(option)
    case option
    when 'EOD'
      now.end_of_day
    when 'EOWeek'
      now.end_of_week - 2.days
    when 'EOWeekend'
      now.end_of_week
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
