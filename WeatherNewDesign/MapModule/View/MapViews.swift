//
//  MapViews.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 02.09.2021.
//

import CoreLocation
import MapKit
import UIKit

final class MapViews: UIView {
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.compact.left"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 9.58, left: 12.33, bottom: 9.58, right: 12.33)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var myGeoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My geolocation", for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func addBackButtonAction(_ popViewController: @escaping(() -> ())) {
        backButton.addAction {
            popViewController()
        }
    }
    
    func addUserLocationAction(_ getUserLocation: @escaping(() -> ())) {
        myGeoButton.addAction {
            getUserLocation()
        }
    }
    
    func setViews() {
        setButtons()
        setConstraints()
    }
    
    private func setButtons() {
        mapView.addSubview(backButton)
        mapView.addSubview(myGeoButton)
        addSubview(mapView)
        
        backButton.layer.cornerRadius = bounds.width / 46.875
        myGeoButton.layer.cornerRadius = bounds.width / 46.875
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 21.13),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: bounds.width / 23.43),
            backButton.widthAnchor.constraint(equalToConstant: bounds.width / 11.71),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),
            
            mapView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            mapView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            mapView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            
            myGeoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            myGeoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            myGeoButton.widthAnchor.constraint(equalToConstant: 175),
            myGeoButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func updateTheme() {
        backButton.backgroundColor = UIColor(named: "navBarBackLight")
        backButton.tintColor = UIColor(named: "navItemLight")
        
    }
    
    func showUserLocation() {
        mapView.showsUserLocation = true
    }
    
    func setLocationManager(artwork: MKAnnotation) {
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.addAnnotation(artwork)
    }
    
    func centerToLocation(initialLocation: CLLocation) {
        mapView.centerToLocation(initialLocation)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 100000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
