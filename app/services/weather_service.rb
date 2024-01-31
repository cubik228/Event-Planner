# app/services/weather_service.rb
class WeatherService
  include HTTParty
  base_uri 'https://api.weatherapi.com/v1'

  def initialize
    @api_key = Rails.application.secrets.weather_api_key
  end

  def get_weather_by_date(date, city)
    formatted_date = date.strftime("%Y-%m-%d")
    encoded_city = URI.encode_www_form_component(city)
    response = self.class.get("/history.json?key=#{@api_key}&q=#{encoded_city}&dt=#{formatted_date}")
    puts "Response code: #{response.code}" # Добавьте эту строку
    puts response.body # Добавьте эту строку
    response.parsed_response if response.success?
  end
  
  
end
