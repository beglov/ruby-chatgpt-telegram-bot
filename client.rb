class Client
  BASE_URL = 'https://api.openai.com'

  def initialize(api_key: ENV.fetch('OPENAI_API_KEY'))
    @api_key = api_key
  end

  # https://platform.openai.com/docs/api-reference/chat/create
  def chat(messages, temperature: 0.7, model: "gpt-3.5-turbo")
    params = {
      messages: messages,
      temperature: temperature,
      model: model
    }
    connection.post("v1/chat/completions", params)
  end

  private

  def connection
    @connection ||= Faraday.new(BASE_URL) do |conn|
      conn.request :json
      conn.request :authorization, 'Bearer', @api_key
      conn.response :json, parser_options: { symbolize_names: true }
      conn.response :logger, nil, { headers: true, bodies: true }
      conn.adapter Faraday.default_adapter
    end
  end
end
