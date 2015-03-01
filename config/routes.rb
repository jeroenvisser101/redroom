Rails.application.routes.draw do
  whitelist = lambda { |req|
    whitelisted_ips = Redroom::Application.config.whitelisted_ips

    if whitelisted_ips.is_a? Array
      whitelisted_ips.include? req.remote_addr
    else
      true
    end
  }

  scope constraints: whitelist do
    root 'site#index'
  end

  get '/keep-alive' => 'site#keep_alive'

  post 'slack/incoming' => 'slack_webhook#incoming_message'
end
