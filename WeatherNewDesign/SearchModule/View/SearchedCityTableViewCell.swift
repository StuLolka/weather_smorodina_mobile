//
//  CustomSearchCell.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 17.08.2021.
//

import UIKit

final class SearchedCityTableViewCell: UITableViewCell {
    
    private let imageViews = MainViews()
    
    lazy var backgroundViewTest: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        return view
    }()
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "---"
        return label
    }()
    
    lazy var firstTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "--°"
        return label
    }()
    
    lazy var secondTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "--°"
        return label
    }()
    
    lazy var sunWeatherImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "sun")
        image.isHidden = true
        return image
    }()
    
    lazy var weatherImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var rainWeatherImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Union")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(backgroundViewTest)
        backgroundViewTest.addSubview(cityNameLabel)
        backgroundViewTest.addSubview(firstTemperatureLabel)
        backgroundViewTest.addSubview(secondTemperatureLabel)
        backgroundViewTest.addSubview(sunWeatherImageView)
        backgroundViewTest.addSubview(weatherImageView)
        backgroundViewTest.addSubview(rainWeatherImageView)
        addConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            backgroundViewTest.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backgroundViewTest.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundViewTest.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundViewTest.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cityNameLabel.centerYAnchor.constraint(equalTo: backgroundViewTest.centerYAnchor),
            cityNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: bounds.width / 17.15),
            cityNameLabel.rightAnchor.constraint(equalTo: centerXAnchor),
            
            firstTemperatureLabel.centerYAnchor.constraint(equalTo: backgroundViewTest.centerYAnchor),
            firstTemperatureLabel.rightAnchor.constraint(equalTo: secondTemperatureLabel.leftAnchor, constant: -8),
            
            secondTemperatureLabel.centerYAnchor.constraint(equalTo: backgroundViewTest.centerYAnchor),
            secondTemperatureLabel.rightAnchor.constraint(equalTo: weatherImageView.leftAnchor, constant: -16),
            
            sunWeatherImageView.topAnchor.constraint(equalTo: weatherImageView.topAnchor, constant: -(bounds.height / 100)),
            sunWeatherImageView.bottomAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: -(bounds.height / 4)),
            sunWeatherImageView.rightAnchor.constraint(equalTo: weatherImageView.rightAnchor, constant: bounds.width / 100),
            sunWeatherImageView.widthAnchor.constraint(equalTo: sunWeatherImageView.heightAnchor),
            
            weatherImageView.topAnchor.constraint(equalTo: backgroundViewTest.topAnchor, constant: bounds.height / 2.5),
            weatherImageView.bottomAnchor.constraint(equalTo: backgroundViewTest.bottomAnchor, constant: -(bounds.height / 2.5)),
            weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor),
            weatherImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -(bounds.width / 17.15)),
            
            rainWeatherImageView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            rainWeatherImageView.rightAnchor.constraint(equalTo: weatherImageView.rightAnchor),
            rainWeatherImageView.leftAnchor.constraint(equalTo: weatherImageView.leftAnchor),
            rainWeatherImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
        ])
        
    }
    
    override func layoutSubviews() {
        backgroundViewTest.layer.cornerRadius = bounds.height / 4.6
        backgroundViewTest.clipsToBounds = true
    }
    
    func setFonts(view: UITableView) {
        let size = view.bounds.height / 41.68
        cityNameLabel.font = .systemFont(ofSize: size)
        firstTemperatureLabel.font = .boldSystemFont(ofSize: size)
        secondTemperatureLabel.font = .boldSystemFont(ofSize: size)
        secondTemperatureLabel.textColor = .gray
        
        cityNameLabel.textColor = Theme.currentTheme.text
        firstTemperatureLabel.textColor = Theme.currentTheme.text
    }
    
    func setCell(isHidden: Bool) {
        if isHidden {
            backgroundColor = Theme.currentTheme.background
            backgroundViewTest.backgroundColor = Theme.currentTheme.cellBackground
            isUserInteractionEnabled = true
            sunWeatherImageView.alpha = 0.9
            weatherImageView.alpha = 0.9
            cityNameLabel.alpha = 1
            rainWeatherImageView.alpha = 1
            firstTemperatureLabel.alpha = 1
            secondTemperatureLabel.alpha = 1
            secondTemperatureLabel.textColor = UIColor(named: "grayTextColor")
            
        }
        else {
            backgroundColor = UIColor(named: "tableViewBackPopUpView")
            backgroundViewTest.backgroundColor = UIColor(named: "cellBackDark")
            isUserInteractionEnabled = false
            cityNameLabel.alpha = 0.2
            sunWeatherImageView.alpha = 0.2
            weatherImageView.alpha = 0.2
            rainWeatherImageView.alpha = 0.2
            firstTemperatureLabel.alpha = 0.2
            secondTemperatureLabel.alpha = 0.2
        }
    }
}
