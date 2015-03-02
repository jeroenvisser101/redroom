(function (window, $) {
  /**
   * RelativeTime renders `relative_time_tag` but on the client-side.
   *
   * @param {object} options
   * @constructor
   */
  function RelativeTime(options) {
    if (options == null) options = {};

    options.date = new Date(options.date);
    this.settings = $.extend(this.settings, options);
  }

  /**
   *
   * @type {{is: string, format: string}}
   */
  RelativeTime.prototype.settings = {
    is: 'relative-time',
    format: '%d %b %H:%M'
  };

  /**
   * Renders the RelativeTime element.
   *
   * @returns {jQuery}
   */
  RelativeTime.prototype.render = function () {
    var time = new RelativeTimeElement();
    return $(time).attr({
      datetime: this.settings.date.toISOString()
    });
  };

  window.RelativeTime = RelativeTime;
})(window, jQuery);
