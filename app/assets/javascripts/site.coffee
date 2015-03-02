class Site
  constructor: ->
    setInterval(@fetchNew, 10000)

  fetchNew: ->
    since_id = parseInt($('.message-list > li:first-child').data('message-id'))

    # Default since_id to 1
    since_id = 1 unless since_id > 0

    # Fetch new messages
    fetch("/new.json?since_id=#{since_id}").then((response) ->
      response.json()
    ).then((messages) ->
      for message in messages
        site.addMessage(message)
    )

  addMessage: (message) ->
    @getMessage(message).prependTo($('.message-list'))

  getMessage: (message) ->
    list_item = $('<li>', {
      class: 'message-item',
      data: {
        'message-id': message.id
      }
    })

    $("<span>", {
      text: message.username
      class: 'sender'
    }).appendTo(list_item)
    $("<span>", {
      text: message.message
      class: 'message'
    }).appendTo(list_item)
    new RelativeTime(date: message.created_at)
      .render()
      .addClass('time')
      .appendTo(list_item)

    list_item

window.Site = Site;
window.site = new Site();
