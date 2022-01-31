//
//  MapPresenter.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 02.09.2021.
//

import UIKit
import CoreLocation
import MapKit
import NeedleFoundation

protocol MapPresenterDependency: Dependency {
    var network: NetworkProtocol { get }
}

class MapPresenterComponent: Component<MapPresenterDependency> {
    func mapPresenter() -> MapPresenterProtocol {
        return MapPresenter(network: dependency.network)
    }
}

protocol MapViewProtocol: UIViewController {
    var viewBounds: CGRect {get set}
    func showUserLocation()
    func setLocationManager(artwork: Coordinate)
    func centerToLocation(initialLocation: CLLocation)
}

final class MapPresenter:  MapPresenterProtocol {
    var locationManager: MapLocationFacade?
    var view: MapViewProtocol?
    
    var currentLocation: LatitudeLongitude?
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getCurrentLocation() {
        guard let view = view else {return }
        PinSize.size = PinWidthHeight(view.viewBounds.width / 4.93, (view.viewBounds.width / 4.93))
        locationManager?.setLocationManager()
        view.showUserLocation()
    }
}

