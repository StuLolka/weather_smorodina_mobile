//
//  ExtensionMainPresenter.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 19.08.2021.
//

import CoreLocation

extension WeatherPresenter: CLLocationManagerDelegate {
    
    //MARK: - location manager
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first, let network = network, let view = view  else {return }
        network.fetchCurrentLocationWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude, view: view) { currentCity in
            self.loadDataCurrentCity(city: currentCity.name)
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager error: \(error.localizedDescription)")
        guard let view = view else {return }
        view.launchIPRequest()
    }
}
