Rails.application.routes.draw do
  whitelist = lambda { |req|
    Redroom::Application.config.whitelisted_ips.include? req.remote_addr
  }

  scope constraints: whitelist do
    root 'site#index'
  end

  post 'slack/incoming' => 'slack_webhook#incoming_message'
end
