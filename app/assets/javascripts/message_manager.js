(function (window) {
  window.MessageManager = function () {
    /**
     * Amount of milliseconds between polls.
     *
     * @type {number}
     */
    this.interval = 2000;

    /**
     * Starts polling the server for new messages.
     */
    this.startPolling = function () {
      setInterval((this.fetchNew).bind(this), this.interval);
    };

    /**
     * Fetches new messages, adds them to the message list.
     */
    this.fetchNew = function () {
      var self = this;
      var since_id = parseInt($('.message-list > :first-child').data('message-id'));
      if (since_id < 0) since_id = 0;

      fetch("/new.json?since_id=" + since_id).then(function (response) {
        return response.json();
      }).then(function (messages) {
        for (var prop in messages) {
          if (!messages.hasOwnProperty(prop)) continue;

          var message = messages[prop];
          self.addMessage(message);
        }
      });
    };

    /**
     * Adds new message to the message list.
     *
     * @param message
     */
    this.addMessage = function (message) {
      var self = this;
      self.renderMessage(message).prependTo($('.message-list'));
    };

    /**
     * Renders the message-item for the given message_object.
     *
     * @param message
     *
     * @returns {jQuery}
     */
    this.renderMessage = function (message) {
      var message_element = $('<div>', {
        'class': 'message-item',
        data: {
          'message-id': message.id
        }
      });


      renderSender(message.username).appendTo(message_element);
      renderMessageBody(message.message).appendTo(message_element);
      renderTimestamp(message.created_at).appendTo(message_element);

      return message_element;
    };

    /**
     * Renders the timestamp in it's containing element.
     *
     * @param {string} date
     *
     * @returns {jQuery}
     * @private
     */
    var renderTimestamp = function (date) {
      return $('<div class="time" />').append(
        new RelativeTime({
          date: date
        }).render()
      );
    };

    /**
     * Renders the message's body.
     *
     * @param message_body
     *
     * @returns {jQuery}
     * @private
     */
    var renderMessageBody = function (message_body) {
      return $("<div>", {
        text: message_body,
        'class': 'message'
      });
    };

    /**
     * Renders the sender element.
     *
     * @param {string} sender The name of the sender.
     *
     * @returns {*|jQuery|HTMLElement}
     * @private
     */
    var renderSender = function renderSender(sender) {
      return $("<div>", {
        text: sender,
        'class': 'sender -ellipsis'
      });
    };
  };

  window.message_manager = new MessageManager;
  message_manager.startPolling();
})(window);
