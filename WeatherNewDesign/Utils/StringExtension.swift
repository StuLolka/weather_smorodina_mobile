//
//  StringExtension.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 24.08.2021.
//


extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}
