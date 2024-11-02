defmodule Utils.Date do
  def get_current_month_start_end do
    today = Date.utc_today()
    current_month_start = Date.from_erl!({today.year, today.month, 1})
    current_month_end = Date.add(current_month_start, Date.days_in_month(current_month_start) - 1)

    %{
      current_month_start: DateTime.new!(current_month_start, ~T[00:00:00]),
      current_month_end: DateTime.new!(current_month_end, ~T[23:59:59])
    }
  end

  def get_last_month_start_end do
    today = Date.utc_today()

    last_month =
      if today.month == 1,
        do: %{year: today.year - 1, month: 12},
        else: %{year: today.year, month: today.month - 1}

    last_month_start = Date.from_erl!({last_month.year, last_month.month, 1})
    last_month_end = Date.add(last_month_start, Date.days_in_month(last_month_start) - 1)

    %{
      last_month_start: DateTime.new!(last_month_start, ~T[00:00:00]),
      last_month_end: DateTime.new!(last_month_end, ~T[23:59:59])
    }
  end

  def get_current_week_start_end do
    today = Date.utc_today()
    week_start = Date.add(today, -Date.day_of_week(today) + 1)
    week_end = Date.add(week_start, 6)

    %{week_start: week_start, week_end: week_end}
  end

  def get_last_week_start_end do
    %{week_start: current_week_start} = get_current_week_start_end()
    last_week_start = Date.add(current_week_start, -7)
    last_week_end = Date.add(last_week_start, 6)

    %{last_week_start: last_week_start, last_week_end: last_week_end}
  end

  def get_current_year_start_end do
    today = Date.utc_today()
    year_start = Date.from_erl!({today.year, 1, 1})
    year_end = Date.from_erl!({today.year, 12, 31})

    %{year_start: year_start, year_end: year_end}
  end

  def get_last_year_start_end do
    today = Date.utc_today()
    last_year_start = Date.from_erl!({today.year - 1, 1, 1})
    last_year_end = Date.from_erl!({today.year - 1, 12, 31})

    %{last_year_start: last_year_start, last_year_end: last_year_end}
  end

  def get_days_ago(days) do
    Date.add(Date.utc_today(), -days)
  end

  def get_weeks_ago(weeks) do
    Date.add(Date.utc_today(), -weeks * 7)
  end

  def get_months_ago(months) do
    today = Date.utc_today()
    year_diff = div(months, 12)
    month_diff = rem(months, 12)

    target_year = today.year - year_diff
    target_month = today.month - month_diff

    {adjusted_year, adjusted_month} =
      if target_month <= 0 do
        {target_year - 1, target_month + 12}
      else
        {target_year, target_month}
      end

    target_date = Date.from_erl!({adjusted_year, adjusted_month, 1})
    days_in_target_month = Date.days_in_month(target_date)

    day = min(today.day, days_in_target_month)
    Date.from_erl!({adjusted_year, adjusted_month, day})
  end
end
