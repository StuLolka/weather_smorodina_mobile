//
//  WeatherData.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 18.08.2021.
//

import Foundation

struct WeatherData {
    let cityName: String
    let date: String
    let dayOfWeek: String?
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
    
    var mainArray = [String]()
    var descriptionArray = [String]()
    var dateArray = [String]()
    var temeratureArray = [String]()
    var iconArray = [String]()
}
