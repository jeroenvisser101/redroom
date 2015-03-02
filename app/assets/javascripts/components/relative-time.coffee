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
    time = new RelativeTimeElement()
    $(time).attr({
      datetime: @settings.date.toISOString()
    })


window.RelativeTime = RelativeTime
