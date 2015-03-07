(function (window) {
  window.MessageList = function () {
    // Bind self to this
    var self = this;

    /**
     * Amount of milliseconds between polls.
     *
     * @type {Number}
     */
    self.interval = 2000;

    /**
     * Starts polling the server for new messages.
     */
    self.startPolling = function () {
      setInterval(self.fetchNew, self.interval);
    };

    /**
     * Returns the id of the last received message.
     *
     * @returns {Number}
     */
    self.getLastMessageId = function () {
      return parseInt($('.message-list > :first-child').data('message-id'));
    };

    /**
     * Fetches new messages, adds them to the message list.
     */
    self.fetchNew = function () {
      var since_id = self.getLastMessageId();
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
     * Sends a notification for the new message.
     *
     * @param {Object} message
     */
    self.addNotification = function (message) {
      new MessageNotification({
        sender: message.sender,
        message: message.message
      }).show();
    };

    /**
     * Adds new message to the message list.
     *
     * @param {Object} message
     */
    self.addMessage = function (message) {
      self.addNotification(message);
      self.renderMessage(message).prependTo($('.message-list'));
    };

    /**
     * Renders the message-item for the given message_object.
     *
     * @param {Object} message
     *
     * @returns {jQuery}
     */
    self.renderMessage = function (message) {
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
     * @returns {jQuery}
     * @private
     */
    var renderSender = function (sender) {
      return $("<div>", {
        text: sender,
        'class': 'sender -ellipsis'
      });
    };
  };
})(window);
