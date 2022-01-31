//
//  MainViews.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

final class MainViews: UIView {

    private lazy var locationButton: UIButton = {
        let locationButton = UIButton()
        locationButton.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        return locationButton
    }()
    
    private lazy var magnifyingglassButton: UIButton = {
        let magnifyingglassButton = UIButton()
        magnifyingglassButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return magnifyingglassButton
    }()
    
    private lazy var changeThemeButton: UIButton = {
        let changeThemeButton = UIButton()
        changeThemeButton.setImage(UIImage(systemName: "sun.min"), for: .normal)
        return changeThemeButton
    }()
    
    lazy var refreshControl = UIRefreshControl()
    
    lazy var weatherTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        table.showsVerticalScrollIndicator = false
        table.isHidden = true
        return table
    }()
    
    lazy var loading: UIProgressView = {
        let loading = UIProgressView()
        loading.progress = 0.2
        loading.progressTintColor = .blue
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    
    lazy var miniView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageSunWeatherMiniView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "sun")
        image.isHidden = true
        return image
    }()
    
    lazy var imageWeatherMiniView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.9
        return image
    }()
    
    lazy var imageRainWeatherMiniView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.9
        image.image = UIImage(named: "Union")
        image.isHidden = true
        return image
    }()
    
    lazy var temperatureMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "--°"
        label.textAlignment = .center
        return label
    }()
    
    lazy var feelsLikeMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,----- --- --°"
        label.textAlignment = .center
        return label
    }()

    func addUserLocationAction(_ getUserLocation: @escaping(() -> ())) {
        locationButton.addAction {
            getUserLocation()
        }
    }
    
    func addCityAction(_ addCity: @escaping(() -> ())) {
        magnifyingglassButton.addAction {
            addCity()
        }
    }
    
    func addchangeThemeAction(_ changeTheme: @escaping(() -> ())) {
        changeThemeButton.addAction {
            changeTheme()
        }
    }
    
    func setViews(with navigationItem: UINavigationItem) {
        setMainConstraints()
        setConstraintsInMiniView()
        createNavigationBar(navigationItem: navigationItem)
    }
    
    private func setConstraintsInMiniView() {
        miniView.addSubview(dateMiniViewLabel)
        miniView.addSubview(imageSunWeatherMiniView)
        miniView.addSubview(imageWeatherMiniView)
        miniView.addSubview(imageRainWeatherMiniView)
        miniView.addSubview(temperatureMiniViewLabel)
        miniView.addSubview(feelsLikeMiniViewLabel)
        NSLayoutConstraint.activate([
            dateMiniViewLabel.topAnchor.constraint(equalTo: miniView.topAnchor, constant: bounds.height / 40.25),
            dateMiniViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageSunWeatherMiniView.bottomAnchor.constraint(equalTo: imageWeatherMiniView.bottomAnchor, constant: -(miniView.bounds.height / 10.64)),
            imageSunWeatherMiniView.rightAnchor.constraint(equalTo: imageWeatherMiniView.rightAnchor, constant: miniView.bounds.height / 26.65),
            imageSunWeatherMiniView.heightAnchor.constraint(equalTo: imageSunWeatherMiniView.widthAnchor),
            imageSunWeatherMiniView.widthAnchor.constraint(equalToConstant: miniView.bounds.width / 5.125),
            
            imageWeatherMiniView.topAnchor.constraint(equalTo: dateMiniViewLabel.bottomAnchor, constant: bounds.height / 23),
            imageWeatherMiniView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageWeatherMiniView.widthAnchor.constraint(equalToConstant: bounds.width / 3.75),
            imageWeatherMiniView.heightAnchor.constraint(equalTo: imageWeatherMiniView.widthAnchor),
            
            imageRainWeatherMiniView.topAnchor.constraint(equalTo: imageWeatherMiniView.bottomAnchor),
            imageRainWeatherMiniView.leftAnchor.constraint(equalTo: imageWeatherMiniView.leftAnchor),
            imageRainWeatherMiniView.rightAnchor.constraint(equalTo: imageWeatherMiniView.rightAnchor),
            imageRainWeatherMiniView.heightAnchor.constraint(equalToConstant: bounds.width / 15),
            
            temperatureMiniViewLabel.topAnchor.constraint(equalTo: imageWeatherMiniView.bottomAnchor, constant: bounds.height / 32.2),
            temperatureMiniViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            feelsLikeMiniViewLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            feelsLikeMiniViewLabel.topAnchor.constraint(equalTo: temperatureMiniViewLabel.bottomAnchor, constant: bounds.height / 322),
        ])
    }
    
    private func setMainConstraints() {
        addSubview(miniView)
        addSubview(loading)
        addSubview(weatherTableView)
        NSLayoutConstraint.activate([
            miniView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1),
            miniView.centerXAnchor.constraint(equalTo: centerXAnchor),
            miniView.widthAnchor.constraint(equalToConstant: bounds.width / 1.09),
            miniView.heightAnchor.constraint(equalToConstant: bounds.height / 2.35),
            
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.widthAnchor.constraint(equalToConstant: bounds.width / 2),
            
            weatherTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherTableView.topAnchor.constraint(equalTo: miniView.bottomAnchor, constant: bounds.height / 33.35),
            weatherTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            weatherTableView.widthAnchor.constraint(equalToConstant: bounds.width / 1.09),
        ])
    }
    
    func createNavigationBar(navigationItem: UINavigationItem) {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: locationButton)
        magnifyingglassButton.frame = CGRect(x: 0, y: 0, width: bounds.width / 11.71, height: bounds.width / 11.71)
        changeThemeButton.frame = CGRect(x: 0, y: 0, width: bounds.width / 11.71, height: bounds.width / 11.71)
        let magnifyinggItem = UIBarButtonItem.init(customView: magnifyingglassButton)
        let changeItem = UIBarButtonItem.init(customView: changeThemeButton)
        navigationItem.rightBarButtonItems = [magnifyinggItem, changeItem]
        
        NSLayoutConstraint.activate([
            locationButton.widthAnchor.constraint(equalToConstant: bounds.width / 11.71),
            locationButton.heightAnchor.constraint(equalTo: locationButton.widthAnchor),
        ])
        
        locationButton.layer.cornerRadius = bounds.width / 46.875
        locationButton.clipsToBounds = true
        
        magnifyingglassButton.layer.cornerRadius = bounds.width / 46.875
        magnifyingglassButton.clipsToBounds = true
        
        changeThemeButton.layer.cornerRadius = bounds.width / 46.875
        changeThemeButton.clipsToBounds = true
    }
    
    func updateTheme() {
        locationButton.backgroundColor = Theme.currentTheme.navigationItemBack
        locationButton.tintColor = Theme.currentTheme.navigationItemTint
        
        magnifyingglassButton.backgroundColor = Theme.currentTheme.navigationItemBack
        magnifyingglassButton.tintColor = Theme.currentTheme.navigationItemTint
        
        changeThemeButton.backgroundColor = Theme.currentTheme.navigationItemBack
        changeThemeButton.tintColor = Theme.currentTheme.navigationItemTint
    }
}

