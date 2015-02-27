Rails.application.routes.draw do
  get 'site/index'

  root 'site#index'

  post 'slack/incoming' => 'slack_webhook#incoming_website'
end
