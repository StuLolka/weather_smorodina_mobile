////
////  Moduleb.swift
////  WeatherNewDesign
////
////  Created by Сэнди Белка on 16.08.2021.
////
//
import UIKit
import NeedleFoundation

protocol RouterProtocol {
    var navigationController: UINavigationController { get }
    
    func openMainScreen() -> UINavigationController
    func openSearchScreen(delegate: MainWeatherViewController)
    func openCityScreen(cityModelData: CityModelData, image: UIImage, delegate: MainWeatherViewController)
    func openMapScreen()
    func popViewController()
    func popToRootViewController()
}

final class Router: RouterProtocol {
    
    
    private let myRootComponent = MyRootComponent()
    lazy var navigationController = myRootComponent.navigationController
    
    static var shared: RouterProtocol = {
        return Router()
    }()

    private init() {}
    
    func openMainScreen() -> UINavigationController {
        let mainScreen = myRootComponent.getMainScreen()
        navigationController.viewControllers = [mainScreen]
        return navigationController
    }
    
    func openSearchScreen(delegate: MainWeatherViewController) {
        let searchScreen = myRootComponent.getSearchScreen(delegate: delegate)
        navigationController.pushViewController(searchScreen, animated: true)
    }
    
    func openCityScreen(cityModelData: CityModelData, image: UIImage, delegate: MainWeatherViewController) {
        let cityScreen = myRootComponent.getCityScreen(cityModelData: cityModelData, image: image, delegate: delegate)
        navigationController.pushViewController(cityScreen, animated: true)
    }
    
    func openMapScreen() {
        let mapScreen = myRootComponent.getMapScreen()
        navigationController.pushViewController(mapScreen, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
}
