//
//  TimeAndTemperature.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 31.08.2021.
//

import Foundation

final class TimeAndTemperatureData {
    static var data: TimeAndTemperature?
}

struct TimeAndTemperature {
    var timeArray: [String]
    var temperatureArray: [String]
    
    init(time: [String], temperature: [String]) {
        self.timeArray = time
        self.temperatureArray = temperature
    }
}
