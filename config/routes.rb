Rails.application.routes.draw do
  get "weather", to: "weather#forecast"
  get "weather_page", to: "weather#index"
end

