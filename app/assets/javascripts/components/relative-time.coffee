class RelativeTime
  settings: {}

  constructor: (options = {}) ->
    options.date = new Date(options.date)

    defaults = {
      is: 'relative-time'
      format: '%d %b %H:%M',
    }
    @settings = $.extend(defaults, options)

  render: ->
    console.log(@settings)
    $('<time>', {
      datetime: @settings.date.toISOString()
      text: strftime(@settings.format, @settings.date)
    }).attr('is', @settings.is)

window.RelativeTime = RelativeTime
