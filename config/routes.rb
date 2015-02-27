Rails.application.routes.draw do
  root 'site#index'

  post 'slack/incoming' => 'slack_webhook#incoming_website'
end
