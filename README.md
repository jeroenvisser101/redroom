![Screenshot](https://www.dropbox.com/s/6imlvf2aet87n0n/Screenshot%202015-03-02%2022.20.17.png?dl=1)

#redroom: for when communication matters most.
This app is made so you can let your teams without slack see your emergency chat room.

**TL;DR:** An app that displays a specific slack room without needing a Slack account.

## Setup
1. **Deploy this app to Heroku**, add a Postgres database and make sure you add `SLACK_SECRET_TOKEN` to your environment variables, the value will be filled later.
2. **Create a slack outgoing webhook**, by going to https://[your-team].slack.com/services and choosing 'Outgoing Webhooks'. Create a new webhook, add the 'secret' to the environment variable you've created in step 1. As an endpoint, add `https://[your-heroku-slug].herokuapp.com/slack/incoming`. Choose a name and icon if you like, but these aren't used (yet). You'll either have to choose a keyword, or a channel. We prefer to use a #redroom channel.
3. **Browse to your app**, send a message on the channel or with the keyword on slack. It should appear automatically.
