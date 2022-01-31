//
//  MainWeatherViewController.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

protocol WeatherView: AnyObject {
    
    var modelWeather: WeatherModel? {get set}
    
    var modelWeatherArray: [WeatherModel] {get set}
    
    func launchIPRequest()
    func addDataToView()
}

class MainWeatherViewController: UIViewController, WeatherView {
    
    //MARK:- current date
    internal lazy var dateNow: String = {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: date)
    }()
    
    
    //MARK:- bar button item
    internal lazy var locationButton: UIButton = {
        let locationButton = UIButton()
        locationButton.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        locationButton.addTarget(self, action: #selector(getUserLocation), for: .touchUpInside)
        return locationButton
    }()
    
    internal lazy var magnifyingglassButton: UIButton = {
        let magnifyingglassButton = UIButton()
        magnifyingglassButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        magnifyingglassButton.addTarget(self, action: #selector(enterCity), for: .touchUpInside)
        return magnifyingglassButton
    }()
    
    internal lazy var changeThemeButton: UIButton = {
        let changeThemeButton = UIButton()
        changeThemeButton.setImage(UIImage(systemName: "sun.min"), for: .normal)
        changeThemeButton.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        return changeThemeButton
    }()
    
    //MARK:- views
    private let views = Views()
    private let miniViews = SameViews()
    internal lazy var miniView = miniViews.miniView
    internal lazy var dateMiniViewLabel = miniViews.dateMiniViewLabel
    internal lazy var imageSunWeatherMiniView = miniViews.imageSunWeatherMiniView
    internal lazy var imageWeatherMiniView = miniViews.imageWeatherMiniView
    internal lazy var temperatureMiniViewLabel = miniViews.temperatureMiniViewLabel
    internal lazy var feelsLikeMiniViewLabel = miniViews.feelsLikeMiniViewLabel
    internal lazy var weatherTableView = views.weatherTableView
    internal lazy var imageRainWeatherMiniView = miniViews.imageRainWeatherMiniView
    
    //MARK:- modelWeather
    internal var modelWeather: WeatherModel? = nil {
        didSet {
            DispatchQueue.main.async {
                self.addDataToView()
                self.weatherTableView.reloadData()
            }
        }
    }
    
    var modelWeatherArray = [WeatherModel]()
    
    internal var weatherArray = [WeatherData]()
    internal var hourlyArray = [HourlyData]()
    
    internal var presenter: WeatherViewPresenter?
    internal let network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        miniView.addGestureRecognizer(tapGestureRecognizer)
        setConstraints()
        
        presenter?.setLocationManager()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTheme()
    }
    
    //MARK:- Did Layout Subviews
    override func viewDidLayoutSubviews() {
        createNavigationBar()
        setConstraintsInMiniView()
        
        miniView.setGradientBackground(colorTop: UIColor(named: "topGradientDay"), colorBottom: UIColor(named: "bottomGradientDay"))
        miniView.layer.cornerRadius = miniView.bounds.height / 11.66
        miniView.clipsToBounds = true
        
        weatherTableView.rowHeight = view.bounds.height / 3.2
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.register(CustomCellWeatherTableView.self, forCellReuseIdentifier: CustomCellWeatherTableView.idCell)
        
        //MARK:- font
        dateMiniViewLabel.font = .systemFont(ofSize: miniView.bounds.height / 20)
        temperatureMiniViewLabel.font = .systemFont(ofSize: miniView.bounds.height / 5.8)
        feelsLikeMiniViewLabel.font = .systemFont(ofSize: miniView.bounds.height / 20)
    }
    
    //MARK:- nav bar
    private func createNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: locationButton)
        magnifyingglassButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 11.71, height: view.bounds.width / 11.71)
        changeThemeButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 11.71, height: view.bounds.width / 11.71)
        let magnifyinggItem = UIBarButtonItem.init(customView: magnifyingglassButton)
        let changeItem = UIBarButtonItem.init(customView: changeThemeButton)
        navigationItem.rightBarButtonItems = [magnifyinggItem, changeItem]
        
        NSLayoutConstraint.activate([
            locationButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 11.71),
            locationButton.heightAnchor.constraint(equalTo: locationButton.widthAnchor),
        ])
        
        locationButton.layer.cornerRadius = view.bounds.width / 46.875
        locationButton.clipsToBounds = true
        
        magnifyingglassButton.layer.cornerRadius = view.bounds.width / 46.875
        magnifyingglassButton.clipsToBounds = true
        
        changeThemeButton.layer.cornerRadius = view.bounds.width / 46.875
        changeThemeButton.clipsToBounds = true
    }
    
    //MARK:- constraints
    private func setConstraints() {
        view.addSubview(miniView)
        miniView.addSubview(dateMiniViewLabel)
        miniView.addSubview(imageSunWeatherMiniView)
        miniView.addSubview(imageWeatherMiniView)
        miniView.addSubview(imageRainWeatherMiniView)
        miniView.addSubview(temperatureMiniViewLabel)
        miniView.addSubview(feelsLikeMiniViewLabel)
        view.addSubview(weatherTableView)
        NSLayoutConstraint.activate([
            miniView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            miniView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            miniView.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.09),
            miniView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.35),
            
            weatherTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherTableView.topAnchor.constraint(equalTo: miniView.bottomAnchor, constant: view.bounds.height / 33.35),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherTableView.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.09),
        ])
    }
    
    private func setConstraintsInMiniView() {
        NSLayoutConstraint.activate([
            dateMiniViewLabel.topAnchor.constraint(equalTo: miniView.topAnchor, constant: view.bounds.height / 40.25),
            dateMiniViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageSunWeatherMiniView.bottomAnchor.constraint(equalTo: imageWeatherMiniView.bottomAnchor, constant: -(miniView.bounds.height / 12.77)),
            imageSunWeatherMiniView.rightAnchor.constraint(equalTo: imageWeatherMiniView.rightAnchor, constant: miniView.bounds.height / 32.63),
            imageSunWeatherMiniView.heightAnchor.constraint(equalTo: imageSunWeatherMiniView.widthAnchor),
            imageSunWeatherMiniView.widthAnchor.constraint(equalToConstant: miniView.bounds.width / 5.125),
            
            imageWeatherMiniView.topAnchor.constraint(equalTo: dateMiniViewLabel.bottomAnchor, constant: view.bounds.height / 23),
            imageWeatherMiniView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageWeatherMiniView.widthAnchor.constraint(equalToConstant: miniView.bounds.width / 4.02),
            imageWeatherMiniView.heightAnchor.constraint(equalTo: imageWeatherMiniView.widthAnchor),
            
            imageRainWeatherMiniView.topAnchor.constraint(equalTo: imageWeatherMiniView.bottomAnchor),
            imageRainWeatherMiniView.leftAnchor.constraint(equalTo: imageWeatherMiniView.leftAnchor),
            imageRainWeatherMiniView.rightAnchor.constraint(equalTo: imageWeatherMiniView.rightAnchor),
            imageRainWeatherMiniView.heightAnchor.constraint(equalToConstant: view.bounds.width / 15),
            
            temperatureMiniViewLabel.topAnchor.constraint(equalTo: imageWeatherMiniView.bottomAnchor, constant: view.bounds.height / 32.2),
            temperatureMiniViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            feelsLikeMiniViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsLikeMiniViewLabel.topAnchor.constraint(equalTo: temperatureMiniViewLabel.bottomAnchor, constant: view.bounds.height / 322),
        ])
    }
    
    private func updateTheme() {
        view.backgroundColor = Theme.currentTheme.background
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.background
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.text ?? .black]
        
        weatherTableView.backgroundColor = Theme.currentTheme.background
        weatherTableView.reloadData()
        
        
        locationButton.backgroundColor = Theme.currentTheme.navigationItemBack
        locationButton.tintColor = Theme.currentTheme.navigationItemTint
        
        magnifyingglassButton.backgroundColor = Theme.currentTheme.navigationItemBack
        magnifyingglassButton.tintColor = Theme.currentTheme.navigationItemTint
        
        changeThemeButton.backgroundColor = Theme.currentTheme.navigationItemBack
        changeThemeButton.tintColor = Theme.currentTheme.navigationItemTint
    }
    
    internal func addDataToView() {
        DispatchQueue.main.async {
            guard let model = self.modelWeather else {return }
            
            self.title = model.city.name
            self.dateMiniViewLabel.text = "Today, \(self.dateNow)"
            self.imageWeatherMiniView.image = WeatherImage.returnImage(main: model.list[0].weather[0].main, description: model.list[0].weather[0].description, rain: self.imageRainWeatherMiniView, sun: self.imageSunWeatherMiniView)
            self.temperatureMiniViewLabel.text = String(Int(model.list[0].main.temp)) + "°C"
            self.feelsLikeMiniViewLabel.text = "\(model.list[0].weather[0].description), feels like \(Int(model.list[0].main.feels_like))°C"
            self.weatherTableView.isHidden = false
        }
    }
    
    internal func launchIPRequest() {
        
        network.fetchCurrentLocationWeatherByIP { (city) in
            guard var presenter = self.presenter else {return }
            presenter.cityNameEng = city.city
            presenter.loadDataCurrentCity(city: city.city)
        }
    }
    
    //MARK:- @objc func
    @objc func didTapView() {
        guard let modelWeather = modelWeather else {
            return
        }
        let data = WeatherData(cityName: modelWeather.city.name,
                               date: "Today, \(dateNow)", main: modelWeather.list[0].weather[0].main,
                               description: modelWeather.list[0].weather[0].description,
                               wind: String(Int(modelWeather.list[0].wind.speed)),
                               pressure: String(modelWeather.list[0].main.pressure),
                               temperature: String(Int(modelWeather.list[0].main.temp)),
                               image: modelWeather.list[0].weather[0].icon,
                               temp_max: String(Int(modelWeather.list[0].main.temp_max)),
                               feelsLike: String(Int(modelWeather.list[0].main.feels_like)),
                               humidity: String(modelWeather.list[0].main.humidity),
                               precipitation: String(Int(modelWeather.list[0].pop)))
        navigationController?.pushViewController(ModuleBuilder.CityModule(model: data), animated: true)
    }
    
    @objc func getUserLocation() {
        
    }
    
    @objc func enterCity() {
        let vc = ModuleBuilder.SearchModule()
        vc.weatherViewController = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeTheme() {
        Theme.changeTheme()
        updateTheme()
    }
    
}
