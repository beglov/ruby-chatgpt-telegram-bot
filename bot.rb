require 'dotenv/load'
require 'telegram/bot'
require 'logger'
require_relative 'client'

token = ENV.fetch('TELEGRAM_BOT_TOKEN')
$telegram_user_ids = ENV.fetch('TELEGRAM_USER_IDS', '').split(',')

def client
  @client ||= Client.new
end

def logger
  @logger ||= Logger.new($stdout)
end

def ask_chatgpt(messages, user_message)
  return "Ask me anything you want" if user_message.text == '/start'

  response = client.chat(messages)

  return "Service Temporarily Unavailable" unless response.success?

  response.body[:choices][0][:message][:content]
rescue StandardError => e
  logger.error e
  "Service Temporarily Unavailable"
end

def handle_message(bot, message)
  # return if message != Telegram::Bot::Types::Message
  return "Access denied" if !$telegram_user_ids.empty? && !$telegram_user_ids.include?(message.from&.id.to_s)

  # Get the user's input text
  input_text = message.text

  messages = [
    { role: "user", content: input_text }
  ]
  answer = ask_chatgpt(messages, message)

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
