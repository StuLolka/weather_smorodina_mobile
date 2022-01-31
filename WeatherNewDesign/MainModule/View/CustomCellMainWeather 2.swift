//
//  CustomCellMainWeather.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

final class CustomCellWeatherTableView: UITableViewCell {
    static let idCell = "UITableViewCellCustomCellWeatherTableView"
    var collectionViewArray: [CollectionCellModel] = []
    
    var weatherModel: WeatherData?
    internal lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "-- ----, --"
        return label
    }()
    
    internal lazy var firstTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--°"
        return label
    }()
    
    internal lazy var secondTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--°"
        return label
    }()
    
    internal lazy var line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    internal let imageSunWeatherMiniView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "sun")
        image.isHidden = true
        return image
    }()
    
    internal lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.image = .checkmark
        weatherImageView.contentMode = .scaleAspectFit
        return weatherImageView
    }()
    
    internal let imageRainWeatherMiniView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Union")
        image.isHidden = true
        return image
    }()
    
    internal lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.idCell)
        weatherCollectionView.alwaysBounceHorizontal = true
        weatherCollectionView.isScrollEnabled = true
        weatherCollectionView.showsHorizontalScrollIndicator = false
        return weatherCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        addSubview(firstTemperatureLabel)
        addSubview(secondTemperatureLabel)
        addSubview(imageSunWeatherMiniView)
        addSubview(weatherImageView)
        addSubview(imageRainWeatherMiniView)
        addSubview(line)
        addSubview(weatherCollectionView)
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: bounds.height / 7.3),
            
            firstTemperatureLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            firstTemperatureLabel.rightAnchor.constraint(equalTo: secondTemperatureLabel.leftAnchor, constant: -8),
            
            secondTemperatureLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            secondTemperatureLabel.rightAnchor.constraint(equalTo: weatherImageView.leftAnchor, constant: -16),
            
            imageSunWeatherMiniView.bottomAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: -(bounds.height / 25)),
            imageSunWeatherMiniView.rightAnchor.constraint(equalTo: weatherImageView.rightAnchor, constant: bounds.width / 48),
            imageSunWeatherMiniView.widthAnchor.constraint(equalToConstant: bounds.width / 15),
            imageSunWeatherMiniView.heightAnchor.constraint(equalToConstant: bounds.height / 15),
            
            weatherImageView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            weatherImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            weatherImageView.heightAnchor.constraint(equalToConstant: 30),
            weatherImageView.widthAnchor.constraint(equalToConstant: 30),
            
            imageRainWeatherMiniView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            imageRainWeatherMiniView.rightAnchor.constraint(equalTo: weatherImageView.rightAnchor),
            imageRainWeatherMiniView.leftAnchor.constraint(equalTo: weatherImageView.leftAnchor),
            imageRainWeatherMiniView.heightAnchor.constraint(equalToConstant: 15),
            
            line.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 18),
            line.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            line.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            weatherCollectionView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            weatherCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            weatherCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            weatherCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    internal func setFonts(view: UIView) {
        let size = view.bounds.height / 41.68
        dateLabel.font = .systemFont(ofSize: size)
        firstTemperatureLabel.font = .boldSystemFont(ofSize: size)
        secondTemperatureLabel.font = .systemFont(ofSize: size)
        secondTemperatureLabel.textColor = UIColor(named: "grayTextColor")
        
        dateLabel.textColor = Theme.currentTheme.text
        firstTemperatureLabel.textColor = Theme.currentTheme.text
        secondTemperatureLabel.textColor = Theme.currentTheme.text
    }
}
