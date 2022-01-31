//
//  Router.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 04.10.2021.
//

import UIKit
import NeedleFoundation

final class MyRootComponent: BootstrapComponent {

    var navigationController: UINavigationController {
        UINavigationController()
    }
    
    var network: NetworkProtocol {
        Network()
    }
    
    var location: LocationFacadeProtocol {
        LocationFacade()
    }
    
    private lazy var weatherPresenter = WeatherPresenterComponent(parent: self).weatherPresenter()
    private lazy var searchPresenter = SearchPresenterComponent(parent: self).searchPresenter()
    private lazy var cityPresenter = CityPresenterComponent(parent: self).cityPresenter()
    private lazy var mapPresenter = MapPresenterComponent(parent: self).mapPresenter()
    
    func getMainScreen() -> WeatherViewProtocol {
        let mainScreen = MainWeatherViewController(presenter: weatherPresenter)
        mainScreen.presenter?.view = mainScreen
        return mainScreen
    }
    
    func getSearchScreen(delegate: MainWeatherViewController) -> SearchTableViewProtocol {
        let searchScreen = SearchTableViewController(presenter: searchPresenter)
        searchScreen.observer = delegate
        searchScreen.weatherViewController = delegate
        searchScreen.presenter?.view = searchScreen
        return searchScreen
    }
    
    func getCityScreen(cityModelData: CityModelData, image: UIImage, delegate: MainWeatherViewController) -> CityWeatherProtocol {
        let cityScreen = CityWeatherController(presenter: cityPresenter, delegate: delegate)
        cityScreen.presenter?.view = cityScreen
        cityScreen.presenter?.cityModelData = cityModelData
        cityScreen.backImage = image
        return cityScreen
    }
    
    func getMapScreen() -> MapViewProtocol {
        let mapScreen = MapViewController(presenter: mapPresenter)
        mapScreen.presenter?.view = mapScreen
        mapScreen.presenter?.locationManager = MapLocationFacade(presenter: mapPresenter, network: network)
        return mapScreen
    }
}
