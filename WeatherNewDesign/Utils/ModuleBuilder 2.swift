//
//  Moduleb.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

final class ModuleBuilder {
    public static let languageSubstring = NSLocale.preferredLanguages.first?.split(separator: "-")

    static func MainModule() -> UIViewController {
        let view = MainWeatherViewController()
        view.presenter = WeatherPresenter(view: view, network: view.network)
//        view.presenter?.language = String(languageSubstring?[0] ?? "en")
        return view
    }
    
    static func SearchModule() -> SearchTableViewController {
        let view = SearchTableViewController()
        view.presenter = SearchPresenter(view: view, network: view.network)
        return view
    }
    
    static func CityModule(model: WeatherData) -> UIViewController {
        let view = CityWeather()
        view.modelWeather = model
        return view
    }
}
