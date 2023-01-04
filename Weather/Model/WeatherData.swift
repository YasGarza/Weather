//
//  WeatherData.swift
//  Weather
//
//  Created by Yas Garza on 02/01/23.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: MainWeather
    let weather: [WeatherCondition]
}

struct MainWeather: Decodable {
    let temp: Double
}

struct WeatherCondition: Decodable {
    let id: Int
    let description: String
}
