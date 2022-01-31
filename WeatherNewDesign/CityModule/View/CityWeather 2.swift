//
//  CityWeather.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 17.08.2021.
//

import UIKit
import Charts

class CityWeather: UIViewController {
    
    internal var modelWeather: WeatherData? = nil {
        didSet {
            DispatchQueue.main.async {
                self.addDataToLabel()
            }
        }
    }
    
    //MARK:- views
    private let miniViews = SameViews()
    internal lazy var miniView = miniViews.miniView
    internal lazy var dateMiniViewLabel = miniViews.dateMiniViewLabel
    internal lazy var imageWeatherMiniView = miniViews.imageWeatherMiniView
    internal lazy var temperatureMiniViewLabel = miniViews.temperatureMiniViewLabel
    internal lazy var feelsLikeMiniViewLabel = miniViews.feelsLikeMiniViewLabel
    internal lazy var windTextLabel = miniViews.windTextMiniViewLabel
    internal lazy var humidityTextLabel = miniViews.humidityTextMiniViewLabel
    internal lazy var precipitationTextLabel = miniViews.precipitationMiniViewTextLabel
    internal lazy var windRateLabel = miniViews.windRateMiniViewLabel
    internal lazy var humidityRateLabel = miniViews.humidityRateMiniViewLabel
    internal lazy var precipitationRateLabel = miniViews.precipitationRateMiniViewLabel
    
    //MARK:- bar button item
    private lazy var backButton = miniViews.backButton
    
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
    
    //MARK:- Charts
    private lazy var lineChartView: LineChartView = {
        let line = LineChartView()
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        createNavigationBar()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTheme()
    }
    
    override func viewDidLayoutSubviews() {
        //MARK:- set miniView
        miniView.setGradientBackground(colorTop: UIColor(named: "topGradientDay"), colorBottom: UIColor(named: "bottomGradientDay"))
        miniView.layer.cornerRadius = miniView.bounds.height / 11.66
        miniView.clipsToBounds = true
        
        //MARK:- font
        dateMiniViewLabel.font = .systemFont(ofSize: miniView.bounds.height / 20)
        temperatureMiniViewLabel.font = .systemFont(ofSize: miniView.bounds.height / 5.8)
        feelsLikeMiniViewLabel.font = .systemFont(ofSize: miniView.bounds.height / 20)
        windTextLabel.font = .systemFont(ofSize: miniView.bounds.height / 26)
        humidityTextLabel.font = .systemFont(ofSize: miniView.bounds.height / 26)
        precipitationTextLabel.font = .systemFont(ofSize: miniView.bounds.height / 26)
        windRateLabel.font = .systemFont(ofSize: miniView.bounds.height / 18)
        humidityRateLabel.font = .systemFont(ofSize: miniView.bounds.height / 18)
        precipitationRateLabel.font = .systemFont(ofSize: miniView.bounds.height / 18)
        
        
        backButton.layer.cornerRadius = backButton.bounds.height / 4
        backButton.clipsToBounds = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
    }
    
    private func createNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        let magnifyinggItem = UIBarButtonItem.init(customView: magnifyingglassButton)
        let changeItem = UIBarButtonItem.init(customView: changeThemeButton)
        navigationItem.rightBarButtonItems = [magnifyinggItem, changeItem]
    }
    

    private func setConstraints() {
        view.addSubview(miniView)
        miniView.addSubview(dateMiniViewLabel)
        miniView.addSubview(imageWeatherMiniView)
        miniView.addSubview(temperatureMiniViewLabel)
        miniView.addSubview(feelsLikeMiniViewLabel)
        miniView.addSubview(windTextLabel)
        miniView.addSubview(humidityTextLabel)
        miniView.addSubview(precipitationTextLabel)
        miniView.addSubview(windRateLabel)
        miniView.addSubview(humidityRateLabel)
        miniView.addSubview(precipitationRateLabel)
        view.addSubview(lineChartView)
        NSLayoutConstraint.activate([
            miniView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            miniView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            miniView.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.09),
            miniView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.92),
            
            dateMiniViewLabel.topAnchor.constraint(equalTo: miniView.topAnchor, constant: view.bounds.height / 40.25),
            dateMiniViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageWeatherMiniView.topAnchor.constraint(equalTo: dateMiniViewLabel.bottomAnchor, constant: view.bounds.height / 23),
            imageWeatherMiniView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageWeatherMiniView.widthAnchor.constraint(equalToConstant: view.bounds.width / 3.75),
            imageWeatherMiniView.heightAnchor.constraint(equalTo: imageWeatherMiniView.widthAnchor),
            
            temperatureMiniViewLabel.topAnchor.constraint(equalTo: imageWeatherMiniView.bottomAnchor, constant: view.bounds.height / 40),
            temperatureMiniViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            feelsLikeMiniViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsLikeMiniViewLabel.topAnchor.constraint(equalTo: temperatureMiniViewLabel.bottomAnchor, constant: view.bounds.height / 322),
            
            windTextLabel.centerYAnchor.constraint(equalTo: humidityTextLabel.centerYAnchor),
            windTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width / 7),
            
            windRateLabel.centerYAnchor.constraint(equalTo: humidityRateLabel.centerYAnchor),
            windRateLabel.centerXAnchor.constraint(equalTo: windTextLabel.centerXAnchor),
            
            humidityTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            humidityTextLabel.topAnchor.constraint(equalTo: feelsLikeMiniViewLabel.bottomAnchor, constant: view.bounds.height / 50),
            
            humidityRateLabel.centerXAnchor.constraint(equalTo: humidityTextLabel.centerXAnchor),
            humidityRateLabel.topAnchor.constraint(equalTo: humidityTextLabel.bottomAnchor, constant: 2),
            
            precipitationTextLabel.centerYAnchor.constraint(equalTo: humidityTextLabel.centerYAnchor),
            precipitationTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -(view.bounds.width / 7)),
            
            precipitationRateLabel.centerYAnchor.constraint(equalTo: humidityRateLabel.centerYAnchor),
            precipitationRateLabel.centerXAnchor.constraint(equalTo: precipitationTextLabel.centerXAnchor)
        ])
    }
    
    private func updateTheme() {
        view.backgroundColor = Theme.currentTheme.background
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.background
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.text ?? .black]
        
        backButton.backgroundColor = Theme.currentTheme.navigationItemBack
        backButton.tintColor = Theme.currentTheme.navigationItemTint
        
        magnifyingglassButton.backgroundColor = Theme.currentTheme.navigationItemBack
        magnifyingglassButton.tintColor = Theme.currentTheme.navigationItemTint
        
        changeThemeButton.backgroundColor = Theme.currentTheme.navigationItemBack
        changeThemeButton.tintColor = Theme.currentTheme.navigationItemTint
        
        lineChartView.backgroundColor = Theme.currentTheme.chartsBack
    }
    
    private func addDataToLabel() {
        guard let data = modelWeather else {
            print("error modelWeather")
            return
        }
        title = data.cityName
        dateMiniViewLabel.text = data.date
        imageWeatherMiniView.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(data.image)@2x.png")
        temperatureMiniViewLabel.text = data.temperature + "°C"
        feelsLikeMiniViewLabel.text = "\(data.description), feels like \(data.feelsLike)°C"
        windRateLabel.text = "\(data.wind) m/c"
        humidityRateLabel.text = "\(data.humidity)%"
        precipitationRateLabel.text = "\(data.precipitation)%"
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func enterCity() {
        let vc = ModuleBuilder.SearchModule()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeTheme() {
        Theme.changeTheme()
        updateTheme()
    }
    
    func chart() {
        
    }

}
