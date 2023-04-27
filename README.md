# ChatGPT Telegram bot

This is a telegram bot that allows you to interact with the ChatGPT.

## Usage

First of all, you will need a [Telegram Bot token](https://core.telegram.org/bots#6-botfather)
and an [OpenAI API key](https://beta.openai.com/account/api-keys).
Then you need to copy the `.env.sample` file to `.env` and fill it with your credentials.

You can also specify a list of Telegram user IDs.
In this case, only the specified users will be allowed to interact with the bot.
To get your user ID, message `@userinfobot` on Telegram.
Multiple IDs can be provided, separated by commas.

### Using prebuilt image

```sh
docker run --env-file .env gambit10/ruby-chatgpt-telegram-bot
```

### Build your docker image

```sh
make build
make run
```
