class SiteController < ApplicationController
  def index
    @messages = Message.limit(100).order(created_at: :desc)
  end

  def keep_alive
    render 'OK'
  end
end
