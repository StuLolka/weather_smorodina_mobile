//
//  CityModelData.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 31.08.2021.
//

import Foundation

struct ModelWeatherList {
    let main: String
    let description: String
    let wind: String
    let pressure: String
    let temp_max: String
    let image: String
    let temp_min: String
    let feelsLike: String
    let humidity: String
    let precipitation: String
}

struct CityModelData {
    let cityName: String
    let date: String
    let modelWeatherList: ModelWeatherList
    
    let dateArray: [String]
    let temeratureArray: [String]
}
