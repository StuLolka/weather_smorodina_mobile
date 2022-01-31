//
//  MainWeatherViewController.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit
import CoreLocation

protocol WeatherPresenterProtocol {
    var view: WeatherViewProtocol? {get set}
    
    func loadDataCurrentCity(city: String)
    func getCurrentLocationWeatherByIP()
    func getWeather(city: String)
    func getCurrentLocationUser()
    func getCityName() -> String?
    func setCityModelData(date: String)
    func updateMainWeatherArray()
    func getData(from coordinate: CLLocationCoordinate2D)
    func getDataFromIP()
}

final class MainWeatherViewController: UIViewController, WeatherViewProtocol {
    let router = Router.shared
    private var delegate: SearchDelegate?
    
    var presenter: WeatherPresenterProtocol?
    //MARK:- views
    var mainViews = MainViews()
    
    //MARK:- Progress View
    lazy var loading = mainViews.loading
    
    //MARK:- closures
    private lazy var getUserLocation = {
        self.router.openMapScreen()
    }
    
    private lazy var addCity = {
        self.router.openSearchScreen(delegate: self)
    }
    
    private lazy var changeTheme = {
        Theme.changeTheme()
        self.updateTheme()
    }
    
    //MARK:- init
    init(presenter: WeatherPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = nil
    }
    
    //MARK:- load view
    override func loadView() {
        self.view = mainViews
        self.view.bounds = UIScreen.main.bounds
        mainViews.setViews(with: navigationItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        mainViews.miniView.addGestureRecognizer(tapGestureRecognizer)
        mainViews.addUserLocationAction(getUserLocation)
        mainViews.addCityAction(addCity)
        mainViews.addchangeThemeAction(changeTheme)
        
        mainViews.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        mainViews.weatherTableView.addSubview(mainViews.refreshControl)
        
        presenter?.getCurrentLocationUser()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        mainViews.weatherTableView.reloadData()
        updateTheme()
    }
    
    //MARK:- Did Layout Subviews
    override func viewDidLayoutSubviews() {
        mainViews.miniView.layer.cornerRadius = mainViews.miniView.bounds.height / 11.66
        setTableView()
        setFonts()
    }
    
    func addDataToView(from model: WeatherModel, with date: String) {
        DispatchQueue.main.async { [self] in
            var model = model
            if let timezone = TimeZone(secondsFromGMT: model.city.timezone) {
                self.setViews(with: timezone, current: date)
            }
            guard var modelListZeroElement = ArrayExtension.getElementFromArray(0, &model.list) else {return }
            guard let weatherZeroElement = ArrayExtension.getElementFromArray(0, &modelListZeroElement.weather) else {return }
            mainViews.imageWeatherMiniView.image = WeatherImage.returnImage(main: weatherZeroElement.main, description: model.list[0].weather[0].description, rain: mainViews.imageRainWeatherMiniView, sun: mainViews.imageSunWeatherMiniView)
            mainViews.temperatureMiniViewLabel.text = String(Int(modelListZeroElement.main.temp_max)).addDegreeSymbol()
            mainViews.feelsLikeMiniViewLabel.text = "\(weatherZeroElement.description), feels like \(Int(modelListZeroElement.main.feels_like))".addDegreeSymbol().firstUppercased
            loading.isHidden = true
            mainViews.weatherTableView.isHidden = false
            mainViews.miniView.isHidden = false
            title = model.city.name
        }
        mainViews.weatherTableView.reloadData()
    }
    
    func setProgress(loading: Float) {
        self.loading.progress = loading
    }
    
    func endRefreshing() {
        mainViews.refreshControl.endRefreshing()
    }
    
    func pushToCityView(cityModelData: CityModelData) {
        guard let image = mainViews.miniView.image else { return }
        router.openCityScreen(cityModelData: cityModelData, image: image, delegate: self)
    }
    
    private func setTableView() {
        mainViews.weatherTableView.rowHeight = view.bounds.height / 3.2
        mainViews.weatherTableView.delegate = self
        mainViews.weatherTableView.dataSource = self
        mainViews.weatherTableView.register(CustomCellWeatherTableView.self, forCellReuseIdentifier: CustomCellWeatherTableView.idCell)
    }
    
    //MARK:- fonts
    private func setFonts() {
        mainViews.dateMiniViewLabel.font = .systemFont(ofSize: mainViews.miniView.bounds.height / 20)
        mainViews.temperatureMiniViewLabel.font = .boldSystemFont(ofSize: mainViews.miniView.bounds.height / 5.8)
        mainViews.feelsLikeMiniViewLabel.font = .systemFont(ofSize: mainViews.miniView.bounds.height / 20)
    }
    
    private func updateTheme() {
        view.backgroundColor = Theme.currentTheme.background
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.background
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.text ?? .black]
        
        mainViews.weatherTableView.backgroundColor = Theme.currentTheme.background
        mainViews.weatherTableView.reloadData()
        
        mainViews.updateTheme()
    }
    
    private func setViews(with timezone: TimeZone, current dateString: String) {
        let date = DateTime.getDate(date: dateString)
        let mounth = DateTime.getMonthName(date)
        let dayOfWeek = DateTime.getDayOfWeek(date)
        setBackMiniView(time: DateTime.timeOfDay(hourString: DateTime.getTime(date: dateString)))
        mainViews.dateMiniViewLabel.text = "Today, \(DateTime.getCurrentDay(date: date)) \(mounth), \(dayOfWeek)"
    }
    
    private func setBackMiniView(time: BackgroundMiniView) {
        switch time {
        case .night:
            mainViews.miniView.image = UIImage(named: "nightNight")
        case .dawnNightfall:
            mainViews.miniView.image = UIImage(named: "zakatZakat")
        case .day:
            mainViews.miniView.image = UIImage(named: "dayDay")
        }
    }
    
    //MARK:- @objc func
    @objc func refresh() {
        guard let city = title else {
            print("title city error")
            return
        }
        presenter?.getWeather(city: city)
    }
    
    @objc func didTapView() {
        guard let date = mainViews.dateMiniViewLabel.text else {
            print("error date")
            return
        }
        presenter?.setCityModelData(date: date)
    }
}

extension MainWeatherViewController: SearchDelegate {
    func updateCity(with name: String) {
        title = name
        presenter?.loadDataCurrentCity(city: name)
    }
}

//MARK: - convert
extension Date {
    func toLocalTime(timezone: TimeZone) -> String {
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        let date =  Date(timeInterval: seconds, since: self)
        return "\(date)"
    }
}
