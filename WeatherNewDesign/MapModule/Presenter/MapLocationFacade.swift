//
//  LocationFacade.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 02.09.2021.
//

import CoreLocation
import MapKit
import UIKit

final class MapLocationFacade: NSObject {
    static var index = 0
    private var presenter: MapPresenterProtocol
    private let network: NetworkProtocol
    private let locationManager = CLLocationManager()
    
    init(presenter: MapPresenterProtocol, network: NetworkProtocol) {
        self.presenter = presenter
        self.network = network
    }
    
    func setLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        GetWeatherListMajorCity(network: network, facade: self).fillArray()
    }
    
    func addPointToMap(city: MajorCity) {
        let coordinate = Coordinate(coordinate: CLLocationCoordinate2D(latitude: ListMajorCities.citiesArray[MapLocationFacade.index].coordinates.latitude,
                                                                    longitude: ListMajorCities.citiesArray[MapLocationFacade.index].coordinates.longitude))
        MapLocationFacade.index += 1
        presenter.view?.setLocationManager(artwork: coordinate)
    }
}

//        MARK:- zoom to user location
extension MapLocationFacade: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return }
        let initialLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        presenter.view?.centerToLocation(initialLocation: initialLocation)
        presenter.currentLocation = LatitudeLongitude(location.coordinate.latitude, location.coordinate.longitude)
    }
}

final class Coordinate: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}


final class LocationAnnotationView: MKAnnotationView {
    
    static var index = 0
    // MARK: Initialization
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        canShowCallout = true
        setupMapPinView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupMapPinView() {
        backgroundColor = .clear
        
        let view = MapPinView()
        guard let city = ArrayExtension.getElementFromArray(LocationAnnotationView.index, &MajorCityArray.array) else {return }
        view.tempMax.text = city.tempMax.addDegreeSymbol()
        view.tempMin.text = city.tempMin.addDegreeSymbol()
        view.mainImage.image = WeatherImage.returnImage(main: city.main, description: city.description, rain: view.rainImage, sun: view.sunImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: PinSize.size?.width ?? 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: PinSize.size?.height ?? 100).isActive = true
        view.backgroundColor = .white
        view.layer.cornerRadius = (PinSize.size?.width ?? 100) / 7.6
        view.clipsToBounds = true
        view.setConstraints()
        addSubview(view)
        view.frame = bounds
        LocationAnnotationView.index += 1
    }
}
