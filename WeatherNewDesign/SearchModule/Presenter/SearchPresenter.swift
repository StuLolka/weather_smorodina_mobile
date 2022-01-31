//
//  Presenter.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 19.08.2021.
//

import UIKit
import NeedleFoundation

protocol SearchPresenterDependency: Dependency {
    var network: NetworkProtocol { get }
}

class SearchPresenterComponent: Component<SearchPresenterDependency> {
    func searchPresenter() -> SearchPresenterProtocol {
        return SearchPresenter(network: dependency.network)
    }
}

protocol SearchTableViewProtocol: UIViewController {
    func reloadData()
    func setProgress()
    func returnDefaultStyle()
    func reloadDataCollection()
}


final class SearchPresenter: SearchPresenterProtocol {

    var view: SearchTableViewProtocol?
    private let network: NetworkProtocol
    private let language = "en"
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func loadDataCity(city: String) {
        network.fetchWeather(city: city, language: language) { model in
            if !self.isCityExist(city: model.city.name) {
                WeatherModelListSearchedCities.searchedCities.append(model)
                self.view?.reloadData()
            }
        } loading: { loading in
            self.view?.setProgress()
        }
    }
    
    private func isCityExist(city: String) -> Bool {
        for i in WeatherModelListSearchedCities.searchedCities {
            if i.city.name == city {
                return true
            }
        }
        return false
    }
}
