require 'telegram/bot'
require 'openai'

token = ENV.fetch('TELEGRAM_BOT_API_TOKEN')
OpenAI.api_key = ENV.fetch('OPENAI_API_KEY')

def handle_message(bot, message)
  # Get the user's input text
  input_text = message.text

  # Generate a response using ChatGPT
  response = OpenAI.Completion.create(
    engine: 'davinci',
    prompt: input_text,
    max_tokens: 50,
    n: 1,
    stop: nil,
    temperature: 0.5
  )

  # Send the response back to the user
  bot.api.send_message(
    chat_id: message.chat.id,
    text: response.choices[0].text
  )
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    handle_message(bot, message)
  end
end
