# ChatGPT Telegram bot

This is a telegram bot that allows you to interact with the OpenAI ChatGPT model.

## Usage

First of all you need [Telegram Bot token](https://core.telegram.org/bots#6-botfather)
and [OpenAI API key](https://beta.openai.com/account/api-keys).
Tnen you need copy `.env.sample` to `.env` file and replace `TELEGRAM_API_KEY` and `OPENAI_API_KEY` values to yours
tokens.

Then build:

```sh
make build
```

and run you bot:

```sh
make run
```
