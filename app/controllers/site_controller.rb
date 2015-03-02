class SiteController < ApplicationController
  def index
    @messages = Message.limit(100).order(id: :desc)
  end

  def new
    since_id = params[:since_id].to_i
    @messages = Message.where('id > ?', since_id).limit(100).order(id: :asc)

    render json: @messages
  end

  def keep_alive
    render text: 'OK'
  end
end
