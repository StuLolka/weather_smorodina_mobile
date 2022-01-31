//
//  File.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 24.08.2021.
//

import Foundation

enum BackgroundMiniView {
    case night
    case dawnNightfall
    case day
}

final class DateTime {
    
    static func getTime(date: String) -> String {
        var dateString = "\(date)".split(separator: " ")
        guard let element = ArrayExtension.getElementFromArray(1, &dateString) else { return ""}
        var timeSplit = element.split(separator: ":")
        guard let hour = ArrayExtension.getElementFromArray(0, &timeSplit) else { return ""}
        var willReturn = String(hour)
        //MARK:- if time format is not 24
        if dateString.contains("PM") {
            willReturn = convert12To24(String(hour))
        }
        if willReturn == "12" && dateString.contains("AM") {
            return "0"
        }
        return willReturn
    }
    
    private static func convert12To24(_ hour: String) -> String {
        switch hour {
        case "1":
            return "13"
        case "2":
            return "14"
        case "3":
            return "15"
        case "4":
            return "16"
        case "5":
            return "17"
        case "6":
            return "18"
        case "7":
            return "19"
        case "8":
            return "20"
        case "9":
            return "21"
        case "10":
            return "22"
        case "11":
            return "23"
        default:
            return "12"
        }
    }

    
    static func getDate(date: String) -> String {
        var dateString = "\(date)".split(separator: " ")
        guard let element = ArrayExtension.getElementFromArray(0, &dateString) else { return ""}
        return String(element)
    }
    
    static func getTime24(date: String) -> String {
        var dateString = "\(date)".split(separator: " ")
        guard let element = ArrayExtension.getElementFromArray(1, &dateString) else { return ""}
        return String(element)
    }
    
    static func getDayOfWeek(_ today: String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        if formatter.date(from: today) == nil {
            formatter.dateFormat = "yyyy-MM-dd"
        }
        guard let todayDate = formatter.date(from: today) else { return ""}
        
        let formatterTest = DateFormatter()
        formatterTest.dateFormat = "E"
        return formatterTest.string(from: todayDate)
    }

    
    static func getMonthName(_ today: String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return ""}
        
        let formatterTest = DateFormatter()
        formatterTest.dateFormat = "MMMM"
        return formatterTest.string(from: todayDate)
    }
    
    static func getCurrentDay(date: String) -> String {
        var daySplit = date.split(separator: "-")
        guard var element = ArrayExtension.getElementFromArray(2, &daySplit) else { return "" }
        if element.first == "0" {
            element.removeFirst()
        }
        return String(element)
    }
    
    static func timeOfDay(hourString: String) -> BackgroundMiniView {
        var hourSplit = hourString.split(separator: ":")
        guard hourSplit.count > 0 else {return .day }
        guard let element = ArrayExtension.getElementFromArray(0, &hourSplit) else { return .day }
        guard let hour = Int(element) else {
            print("error time of day")
            return .day
        }
        switch hour {
        case 0 ..< 4:
            return .night
        case 4 ..< 12:
            return .dawnNightfall
        case 12 ..< 16:
            return .day
        case 16 ..< 24:
            return .dawnNightfall
        default:
            return .day
        }
    }
    
    static func getArrayTimeForCell(dateArray: [String], i: Int) -> String {
        var dateArray = dateArray
        guard let dateAndTime = ArrayExtension.getElementFromArray(i, &dateArray) else { return ""}
        var dateAndTimeSplit = dateAndTime.split(separator: " ")
        guard let time = ArrayExtension.getElementFromArray(1, &dateAndTimeSplit) else { return ""}
        var timeSplit = time.split(separator: ":")
        guard let hour = ArrayExtension.getElementFromArray(0, &timeSplit), let min = ArrayExtension.getElementFromArray(1, &timeSplit) else { return ""}
        return String(hour).addColonSymbol() + String(min)
    }
    
    static func getTimeWithoutSeconds(date: String) -> String {
        var dateSplit = date.split(separator: " ")
        guard let time = ArrayExtension.getElementFromArray(1, &dateSplit) else { return ""}
        var timeSplit = time.split(separator: ":")
        guard let hour = ArrayExtension.getElementFromArray(0, &timeSplit), let min = ArrayExtension.getElementFromArray(1, &timeSplit) else { return ""}
        return String(hour).addColonSymbol() + String(min)
    }
}
