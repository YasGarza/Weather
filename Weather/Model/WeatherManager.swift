//
//  WeatherManager.swift
//  Weather
//
//  Created by Yas Garza on 02/01/23.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFail(with error: Error)
}

struct WeatherManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    let apiKey = Bundle.main.infoDictionary?["WEATHER_API_KEY"]
    
    var delegate: WeatherManagerDelegate?
    
    private func getFullURL() -> String {
        guard let apiKey = self.apiKey else {
            return ""
        }
        
        return baseUrl + "&appid=\(apiKey)"
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(getFullURL())&q=\(cityName)"
        performRequest(to: urlString)
    }
    
    func fetchWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        let urlString = "\(getFullURL())&lat=\(latitude)&lon=\(longitude)"
        performRequest(to: urlString)
    }
    
    func performRequest(to urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                delegate?.didFail(with: error)
                return
            }
            
            if let data = data {
                if let weather = parseJson(weatherData: data) {
                    delegate?.didUpdateWeather(weather)
                }
            }
        }
        
        task.resume()
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            return WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
        } catch {
            print(error)
            delegate?.didFail(with: error)
            return nil
        }
    }
}
