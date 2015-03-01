Rails.application.routes.draw do
  whitelist = lambda { |req|
    whitelisted_ips = Redroom::Application.config.whitelisted_ips
    whitelisted_ips.include? req.remote_addr
    Rails.logger.warn('IP: ' << req.remote_addr)
  }

  scope constraints: whitelist do
    root 'site#index'
  end

  get '/keep-alive' => 'site#keep_alive'

  post 'slack/incoming' => 'slack_webhook#incoming_message'
end
