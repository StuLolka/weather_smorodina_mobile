//
//  Theme.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 17.08.2021.
//

import UIKit

protocol ThemeProtocol {
    var background: UIColor? {get}
    var text: UIColor? {get}
    var navigationBar: UIColor? {get}
    var cellBackground: UIColor? {get}
    var line: UIColor? {get}
    var navigationItemTint: UIColor? {get}
    var navigationItemBack: UIColor? {get}
    var collectionCellBack: UIColor? {get}
    var textFieldBack: UIColor? {get}
    var borderTextField: UIColor? {get}
    var cancelButtonPopUP: UIColor? {get}
    var cancelButtonTitle: UIColor? {get}
    var popUpBack: UIColor? {get}
    var chartsBack: UIColor? {get}
}


final class Theme {
    static private var isLightTheme = true
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
