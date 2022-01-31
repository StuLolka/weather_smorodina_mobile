//
//  LocationFacade.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 27.08.2021.
//

import CoreLocation
import NeedleFoundation

protocol NetworkDelegate {
    func getData(from coordinate: CLLocationCoordinate2D)
    func getDataFromIP()
}

protocol LocationFacadeProtocol {
    var delegate: NetworkDelegate? {get set}
    func getLocation()
}

final class LocationFacade: NSObject, LocationFacadeProtocol {
    private let locationManager = CLLocationManager()
    
    var delegate: NetworkDelegate?
    
    func getLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension LocationFacade: CLLocationManagerDelegate {
    //MARK: - location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            print("location error")
            return
        }
        delegate?.getData(from: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.getDataFromIP()
    }
}
