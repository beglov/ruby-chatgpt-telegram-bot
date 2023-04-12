require 'telegram/bot'
require 'openai'

token = ENV.fetch('TELEGRAM_BOT_API_TOKEN')

def client
  @client ||= OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
end

def handle_message(bot, message)
  # Get the user's input text
  input_text = message.text

  # Generate a response using ChatGPT
  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo", # Required.
      messages: [{ role: "user", content: input_text }], # Required.
      temperature: 0.7,
    }
  )
  answer = response.dig("choices", 0, "message", "content")

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
