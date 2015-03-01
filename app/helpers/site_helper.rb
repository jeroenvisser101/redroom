module SiteHelper
  def relative_time_tag(date, options)
    options.merge!(
      is: 'relative-time',
      datetime: date.to_time.iso8601
    )

    time_tag date, options
  end
end
