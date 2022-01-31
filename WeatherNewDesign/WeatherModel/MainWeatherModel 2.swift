//
//  MainWeatherModel.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import Foundation

import Foundation

struct CurrentCity: Codable {
    let name: String
    let sys: Sys
}

struct Sys: Codable {
    let country: String
}
struct CurrentCityByIP: Codable {
    let city: String
}

struct WeatherModel: Codable {
    let list: [List]
    let city: City
}

struct List: Codable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let dt_txt: String
    let pop: Float
}

struct Main: Codable {
    let humidity: Int
    let temp: Double
    let pressure: Int
    let feels_like: Double
    let temp_max: Double
}

struct Wind: Codable {
    let speed: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct City: Codable {
    let name: String
    let timezone: Int
    let country: String
}


struct NetworkProperties {
    static let API_KEY = "bdfba249e4cd206073100bbe3978c661"
}
