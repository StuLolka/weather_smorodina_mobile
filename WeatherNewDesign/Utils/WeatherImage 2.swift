//
//  WeatherImage.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 23.08.2021.
//

import UIKit

final class WeatherImage {
    static public func returnImage(main: String, description: String, rain: UIImageView, sun: UIImageView) -> UIImage? {
        
        print("main = \(main), description = \(description)")
        if description == "broken clouds" || description == "scattered clouds" || description == "few clouds" {
            sun.isHidden = false
        }
        else {
            sun.isHidden = true
        }
        
        if main.contains("Clear") {
            rain.isHidden = true
            return UIImage(named: "sun")
        }
        else if main.contains("Cloud"){
            rain.isHidden = true
            return UIImage(named: "cloud")
        }
        else if main.contains("Rain"){
            rain.isHidden = false
            return UIImage(named: "cloud")
        }
        else {
            print("No image for \(main)")
            return .none
        }
    }
}
