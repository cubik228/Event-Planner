class WeatherService
  include HTTParty
  base_uri 'https://api.weatherapi.com/v1'

  def initialize
    @api_key = Rails.application.secrets.weather_api_key
  end

  def get_weather(city)
    encoded_city = URI.encode_www_form_component(city)
    response = self.class.get("/current.json?key=#{@api_key}&q=#{encoded_city}")
    response.parsed_response if response.success?
  end
end
