require 'dotenv/load'
require 'telegram/bot'
require 'logger'
require_relative 'client'

token = ENV.fetch('TELEGRAM_API_KEY')

def client
  @client ||= Client.new
end

def logger
  @logger ||= Logger.new($stdout)
end

def ask_chatgpt(messages)
  response = client.chat(messages)

  return "Service Temporarily Unavailable" unless response.success?

  response.body[:choices][0][:message][:content]
rescue StandardError => e
  logger.error e
  "Service Temporarily Unavailable"
end

def handle_message(bot, message)
  # Get the user's input text
  input_text = message.text

  messages = [
    { role: "user", content: input_text }
  ]
  answer = ask_chatgpt(messages)

  # Send the response back to the user
  bot.api.send_message(
    chat_id: message.chat.id,
    text: answer
  )
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    handle_message(bot, message)
  end
end
