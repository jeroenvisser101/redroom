class SlackWebhookController < ApplicationController
  before_action :check_token

  def incoming_message
    message = Message.create(message_params)
    if message
      render status: :ok
    else
      logger.fatal 'Could not save message to database.'
      render status: :internal_server_error
    end
  end

  def check_token
    unless params[:token] == Rails.application.secrets.slack_secret_token
      logger.fatal 'Slack secret token does not match configured token.'
      render status: :forbidden
    end
  end

  def message_params
    {
      username: params[:user_name],
      channel: params[:channel_name],
      message: params[:text]
    }
  end
end
