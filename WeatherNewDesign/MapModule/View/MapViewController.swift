//
//  MapViewController.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 02.09.2021.
//

import UIKit
import CoreLocation
import MapKit

protocol MapPresenterProtocol {
    var currentLocation: LatitudeLongitude? { get set }
    var view: MapViewProtocol? {get set}
    var locationManager: MapLocationFacade? {get set}
    func getCurrentLocation()
}

class MapViewController: UIViewController, MapViewProtocol {
    private let router = Router.shared
    lazy var viewBounds = view.bounds
    
    var presenter: MapPresenterProtocol?
    
    //MARK:- map view
    lazy var mapViews = MapViews()
    
    //MARK:- closures
    lazy var popViewController = {
        self.router.popViewController()
        return
    }
    
    lazy var getUserLocation = {
        guard let lat = self.presenter?.currentLocation?.latitude, let lon = self.presenter?.currentLocation?.longitude else {
            print("Error current location")
            return
        }
        print("latitude: \(lat), longitude: \(lon)")
        self.centerToLocation(initialLocation: CLLocation(latitude: lat, longitude: lon))
        return
    }
    
    init(presenter: MapPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mapViews
        self.view.bounds = UIScreen.main.bounds
        mapViews.setViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        mapViews.addBackButtonAction(popViewController)
        mapViews.addUserLocationAction(getUserLocation)
        
        presenter?.getCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTheme()
        MapLocationFacade.index = 0
    }
    
    private func updateTheme() {
        view.backgroundColor = Theme.currentTheme.background
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.background
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.text ?? .black]

        mapViews.updateTheme()
    }
    
    func showUserLocation() {
        mapViews.showUserLocation()
    }
    
    func setLocationManager(artwork: Coordinate) {
        mapViews.setLocationManager(artwork: artwork)
    }
    
    func centerToLocation(initialLocation: CLLocation) {
        mapViews.centerToLocation(initialLocation: initialLocation)
    }
}
