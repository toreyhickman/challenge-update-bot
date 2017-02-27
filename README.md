# Challenge Update Slackbot

Dev Bootcamp challenges are hosted as Github repositories.  As challenges are updated and tweaked, the curriculum team needs to notify the rest of the organization (e.g., teachers) of the changes.  This has been done via roughly weekly e-mails, but that process requires time and attention from staff.  This project automates the challenge-update announcements through a slackbot.

When a PR is merged to a challenge repo, a GitHub webhook sends a request to notify the slackbot.  The slackbot will then send a message to the appropriate Slack channel.