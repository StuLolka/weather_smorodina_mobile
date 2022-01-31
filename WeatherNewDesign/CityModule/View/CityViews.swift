//
//  CityViews.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 27.08.2021.
//

import UIKit
import Charts

final class CityViews: UIView {
    
    lazy var lineChartView: LineChartView = {
        let line = LineChartView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.rightAxis.enabled = false
        line.leftAxis.enabled = false
        line.xAxis.drawGridLinesEnabled = false
        line.xAxis.labelPosition = .bottom
        line.doubleTapToZoomEnabled = false
        return line
    }()
    
    lazy var miniView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "topGradientDay")
        view.image = UIImage(named: "Intersect")
        view.contentMode = .scaleToFill
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
    
    lazy var windTextMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Wind"
        label.textAlignment = .left
        return label
    }()
    
    lazy var humidityTextMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Humidity"
        label.textAlignment = .center
        return label
    }()
    
    lazy var precipitationMiniViewTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "PPT"
        label.textAlignment = .right
        return label
    }()
    
    lazy var windRateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .left
        return label
    }()
    
    lazy var humidityRateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .center
        return label
    }()
    
    lazy var precipitationRateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .right
        return label
    }()
    
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
    
    private lazy var magnifyingglassButton: UIButton = {
        let magnifyingglassButton = UIButton()
        magnifyingglassButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        magnifyingglassButton.clipsToBounds = true
        return magnifyingglassButton
    }()
    
    private lazy var changeThemeButton: UIButton = {
        let changeThemeButton = UIButton()
        changeThemeButton.setImage(UIImage(systemName: "sun.min"), for: .normal)
        changeThemeButton.clipsToBounds = true
        return changeThemeButton
    }()
    
    func setMiniViewBackgraund(with image: UIImage?) {
        if let image = image {
            miniView.image = image
        }
    }
    
    func addBackButtonAction(_ popViewController: @escaping(() -> ())) {
        backButton.addAction {
            popViewController()
        }
    }
    
    func addEnterCityAction(_ enterCity: @escaping(() -> ())) {
        magnifyingglassButton.addAction {
            enterCity()
        }
    }
    
    func addChangeThemeAction(_ changeTheme: @escaping(() -> ())) {
        changeThemeButton.addAction {
            changeTheme()
        }
    }
    
    func setViews(with navigationItem: UINavigationItem) {
        addViews()
        setConstraintsMiniView()
        setStandartConstraintsInMiniView()
        setLeftConstraintsInMiniView()
        createNavigationBar(navigationItem: navigationItem)
    }
    
    private func addViews() {
        miniView.addSubview(markerView)
        miniView.addSubview(dateMiniViewLabel)
        miniView.addSubview(imageSunWeatherMiniView)
        miniView.addSubview(imageWeatherMiniView)
        miniView.addSubview(imageRainWeatherMiniView)
        miniView.addSubview(temperatureMiniViewLabel)
        miniView.addSubview(feelsLikeMiniViewLabel)
        miniView.addSubview(windTextMiniViewLabel)
        miniView.addSubview(humidityTextMiniViewLabel)
        miniView.addSubview(precipitationMiniViewTextLabel)
        miniView.addSubview(windRateMiniViewLabel)
        miniView.addSubview(humidityRateMiniViewLabel)
        miniView.addSubview(precipitationRateMiniViewLabel)
        miniView.addSubview(dateMiniViewLabel)
        miniView.addSubview(imageSunWeatherMiniView)
        miniView.addSubview(imageWeatherMiniView)
        miniView.addSubview(imageRainWeatherMiniView)
        miniView.addSubview(temperatureMiniViewLabel)
        miniView.addSubview(feelsLikeMiniViewLabel)
    }
    
    private func setConstraintsMiniView() {
        addSubview(miniView)
        addSubview(lineChartView)
        NSLayoutConstraint.activate([
            miniView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1),
            miniView.centerXAnchor.constraint(equalTo: centerXAnchor),
            miniView.widthAnchor.constraint(equalToConstant: bounds.width / 1.09),
            miniView.heightAnchor.constraint(equalToConstant: bounds.height / 1.92),
            
            lineChartView.topAnchor.constraint(equalTo: miniView.bottomAnchor, constant: 20),
            lineChartView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            lineChartView.leftAnchor.constraint(equalTo: miniView.leftAnchor),
            lineChartView.rightAnchor.constraint(equalTo: miniView.rightAnchor)
        ])
    }
    
    private func setStandartConstraintsInMiniView() {
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
    
    private func setLeftConstraintsInMiniView() {
        NSLayoutConstraint.activate([
            windTextMiniViewLabel.centerYAnchor.constraint(equalTo: humidityTextMiniViewLabel.centerYAnchor),
            windTextMiniViewLabel.leftAnchor.constraint(equalTo: miniView.leftAnchor, constant: bounds.width / 7),
            
            windRateMiniViewLabel.centerYAnchor.constraint(equalTo: humidityRateMiniViewLabel.centerYAnchor),
            windRateMiniViewLabel.centerXAnchor.constraint(equalTo: windTextMiniViewLabel.centerXAnchor),
            
            humidityTextMiniViewLabel.centerXAnchor.constraint(equalTo: miniView.centerXAnchor),
            humidityTextMiniViewLabel.topAnchor.constraint(equalTo: feelsLikeMiniViewLabel.bottomAnchor, constant: bounds.height / 50),
            
            humidityRateMiniViewLabel.centerXAnchor.constraint(equalTo: humidityTextMiniViewLabel.centerXAnchor),
            humidityRateMiniViewLabel.topAnchor.constraint(equalTo: humidityTextMiniViewLabel.bottomAnchor, constant: 10),
            
            precipitationMiniViewTextLabel.centerYAnchor.constraint(equalTo: humidityTextMiniViewLabel.centerYAnchor),
            precipitationMiniViewTextLabel.rightAnchor.constraint(equalTo: miniView.rightAnchor, constant: -(bounds.width / 7)),
            
            precipitationRateMiniViewLabel.centerYAnchor.constraint(equalTo: humidityRateMiniViewLabel.centerYAnchor),
            precipitationRateMiniViewLabel.centerXAnchor.constraint(equalTo: precipitationMiniViewTextLabel.centerXAnchor)
        ])

    }
    
    private func createNavigationBar(navigationItem: UINavigationItem) {

        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        let width = bounds.width / 11.71
        magnifyingglassButton.frame = CGRect(x: 0, y: 0, width: width, height: width)
        changeThemeButton.frame = CGRect(x: 0, y: 0, width: width, height: width)
        let magnifyinggItem = UIBarButtonItem.init(customView: magnifyingglassButton)
        let changeItem = UIBarButtonItem.init(customView: changeThemeButton)
        navigationItem.rightBarButtonItems = [magnifyinggItem, changeItem]
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: bounds.width / 11.71),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),
        ])
        
        let cornerRadius = bounds.width / 46.875
        backButton.layer.cornerRadius = cornerRadius
        magnifyingglassButton.layer.cornerRadius = cornerRadius
        changeThemeButton.layer.cornerRadius = cornerRadius
    }
    
    func updateTheme() {
        backButton.backgroundColor = Theme.currentTheme.navigationItemBack
        backButton.tintColor = Theme.currentTheme.navigationItemTint
        
        magnifyingglassButton.backgroundColor = Theme.currentTheme.navigationItemBack
        magnifyingglassButton.tintColor = Theme.currentTheme.navigationItemTint
        
        changeThemeButton.backgroundColor = Theme.currentTheme.navigationItemBack
        changeThemeButton.tintColor = Theme.currentTheme.navigationItemTint
    }
    
    
    
    
    lazy var markerView: MarkerView = {
        let markerView = MarkerView(offset: CGPoint(x: 10, y: 10))
        markerView.setConstraints()
        markerView.frame = CGRect(x: 0, y: 250, width: 50, height: 50)
        return markerView
    }()
}
