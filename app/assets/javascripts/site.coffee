#= depend_on components/relative-time
class Site
  constructor: ->
    setInterval(@fetchNew, 2000)

  fetchNew: ->
    since_id = parseInt($('.message-list > :first-child').data('message-id'))

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
    list_item = $('<div>', {
      class: 'message-item',
      data: {
        'message-id': message.id
      }
    })

    $("<div>", {
      text: message.username
      class: 'sender -ellipsis'
    }).appendTo(list_item)
    $("<div>", {
      text: message.message
      class: 'message'
    }).appendTo(list_item)
    new RelativeTime(date: message.created_at)
      .render()
      .appendTo(list_item)
      .wrap('<div class="time" />')

    list_item

window.Site = Site;
window.site = new Site();
