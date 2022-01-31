//
//  Presenter.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 19.08.2021.
//

import UIKit

final class SearchPresenter {
    private let view: SearchTableViewController
    private let network: Network
    private let language = "en"
    
    required init(view: SearchTableViewController, network: Network) {
        self.view = view
        self.network = network
    }
    
    internal func loadDataCurrentCity(city: String) {
        network.fetchWeather(city: city, language: language) { model in
            self.view.weatherModelArray.append(model)
        }
    }
}
