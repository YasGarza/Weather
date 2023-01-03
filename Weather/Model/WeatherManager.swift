//
//  WeatherManager.swift
//  Weather
//
//  Created by Yas Garza on 02/01/23.
//

import Foundation

struct WeatherManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    let apiKey = Bundle.main.infoDictionary?["WEATHER_API_KEY"]
    
    private func getFullURL() -> String {
        guard let apiKey = self.apiKey else {
            return ""
        }
        
        return baseUrl + "&appid=\(apiKey)"
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(getFullURL())&q=\(cityName)"
        print(urlString)
    }
}
