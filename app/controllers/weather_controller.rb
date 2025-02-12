require 'net/http'
require 'json'
require 'dotenv/load'

class WeatherController < ApplicationController
  def index
  end
  
  def forecast
    city_name = params[:city]

    if city_name.blank?
      return render json: { error: "Debes proporcionar un nombre de ciudad." }, status: :bad_request
    end

    # 1️⃣ Obtener coordenadas de la ciudad desde Reservamos API
    reservamos_url = URI("https://search.reservamos.mx/api/v2/places?q=#{URI.encode_www_form_component(city_name)}")
    reservamos_response = Net::HTTP.get(reservamos_url)
    cities = JSON.parse(reservamos_response)

    cities = cities.select { |c| c["result_type"] == "city" }

    if cities.empty?
      return render json: { error: "No se encontraron ciudades con ese nombre." }, status: :not_found
    end

    # 2️⃣ Usar OpenWeather API gratuita
    api_key = ENV["OPENWEATHER_API_KEY"]
    weather_results = []

    cities.each do |city|
      lat = city["lat"]
      lon = city["long"]
      weather_url = URI("https://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{lon}&units=metric&appid=#{api_key}")

      weather_response = Net::HTTP.get(weather_url)
      weather_data = JSON.parse(weather_response)

      # Verificar si la API devolvió un error
      if weather_data["cod"] != "200"
        return render json: { error: "Error al obtener el clima: #{weather_data['message']}" }, status: :bad_gateway
      end

      # Procesar datos para obtener temperaturas diarias
      daily_temps = {}

      weather_data["list"].each do |entry|
        date = entry["dt_txt"].split(" ")[0] # Obtener solo la fecha
        temp_min = entry["main"]["temp_min"]
        temp_max = entry["main"]["temp_max"]

        # Si la fecha no existe en el hash, inicializarla
        daily_temps[date] ||= { min_temp: temp_min, max_temp: temp_max }
        daily_temps[date][:min_temp] = [daily_temps[date][:min_temp], temp_min].min
        daily_temps[date][:max_temp] = [daily_temps[date][:max_temp], temp_max].max
      end

      # Convertir el hash en un array de pronósticos
      forecast = daily_temps.map do |date, temps|
        { date: date, min_temp: temps[:min_temp], max_temp: temps[:max_temp] }
      end

      weather_results << {
        city: city["city_name"],
        state: city["state"],
        country: city["country"],
        coordinates: { lat: lat, lon: lon },
        forecast: forecast
      }
    end

    render json: { results: weather_results }
  end
end
