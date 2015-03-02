Rails.application.routes.draw do
  whitelist = lambda { |req|
    remote_addr = req.env['HTTP_X_FORWARDED_FOR'].try(:split, ',').try(:first) ||
      req.env['REMOTE_ADDR']

    whitelisted_ips = Redroom::Application.config.whitelisted_ips
    whitelisted_ips.include? remote_addr
  }

  scope constraints: whitelist do
    root 'site#index'
    get 'new' => 'site#new'
  end

  get '/keep-alive' => 'site#keep_alive'

  post 'slack/incoming' => 'slack_webhook#incoming_message'
  get 'slack/incoming' => 'slack_webhook#incoming_message'
end
