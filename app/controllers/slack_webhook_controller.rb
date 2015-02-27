class SlackWebhookController < ApplicationController
  def incoming_message
    unless params[:token] == Rails.application.secrets.slack_secret_token
      logger.fatal 'Slack secret token does not match configured token.'
      render status: :forbidden
    end

    message_data = {
      channel_name: params[:channel_name],
      username: params[:user_name],
      message: params[:text]
    }
  end
end
