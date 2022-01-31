//
//  MainWeatherPresenter.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import Foundation
import CoreLocation

protocol WeatherViewPresenter {
    var cityNameEng: String {get set}
    
    init(view: WeatherView, network: Network)
    func loadDataCurrentCity(city: String)
    func setLocationManager()
}

final class WeatherPresenter: NSObject, WeatherViewPresenter {
    weak var view: WeatherView?
    var network: Network?
    
    internal var locationManager = CLLocationManager()
    
    public var language = "en"
    internal var cityNameEng = ""
    internal var country = ""
    
    required init(view: WeatherView, network: Network) {
        self.view = view
        self.network = network
        super.init()
    }
    
    internal func loadDataCurrentCity(city: String) {
        guard let network = network else {return }
        network.fetchWeather(city: city, language: language) { model in
            
            self.cityNameEng = city
            self.country = model.city.country
            
            self.view?.modelWeather = model
        }
    }
    
    public func setLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
}
