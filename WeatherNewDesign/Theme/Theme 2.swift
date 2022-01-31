//
//  Theme.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 17.08.2021.
//

import UIKit

final class Theme {
    static var isLightTheme = true
    static var currentTheme: ThemeProtocol = LightTheme()
    
    static func changeTheme() {
        if Theme.isLightTheme {
            Theme.currentTheme = DarkTheme()
        }
        else {
            Theme.currentTheme = LightTheme()
        }
        Theme.isLightTheme = !Theme.isLightTheme
    }
}
