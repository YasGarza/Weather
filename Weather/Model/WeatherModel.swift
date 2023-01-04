//
//  WeatherModel.swift
//  Weather
//
//  Created by Yas Garza on 03/01/23.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    // computed property
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionName: String {
        switch conditionId {
        case 200...202:
            return "cloud.bolt.rain"
        case 203..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.rain"
        case 511:
            return "cloud.sleet"
        case 520..<600:
            return "cloud.heavyrain"
        case 600..<700:
            return "snowflake"
        case 700..<780:
            return "smoke"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
