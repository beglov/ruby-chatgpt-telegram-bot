require 'dotenv/load'
require 'telegram/bot'
require_relative 'client'

token = ENV.fetch('TELEGRAM_BOT_API_TOKEN')

def client
  @client ||= Client.new
end

def ask_chatgpt(messages)
  response = client.chat(messages)

  return response.body[:error][:message] unless response.success?

  response.body[:choices][0][:message][:content]
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
