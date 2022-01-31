//
//  CustomCollectionCell.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 18.08.2021.
//

import UIKit

final class CustomCollectionCell: UICollectionViewCell {
    static let idCell = "UICollectionViewCellCustomCollectionCell"
    
    internal lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--:--"
        return label
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
        weatherImageView.image = .actions
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
    
    internal lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--°"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(timeLabel)
        addSubview(imageSunWeatherMiniView)
        addSubview(weatherImageView)
        addSubview(temperatureLabel)
        addSubview(imageRainWeatherMiniView)
        addConstraints()
        setFonts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {

        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageSunWeatherMiniView.bottomAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: -(bounds.height / 7)),
            imageSunWeatherMiniView.rightAnchor.constraint(equalTo: weatherImageView.rightAnchor, constant: bounds.width / 26.07),
            imageSunWeatherMiniView.heightAnchor.constraint(equalTo: imageSunWeatherMiniView.widthAnchor),
            imageSunWeatherMiniView.widthAnchor.constraint(equalToConstant: bounds.width / 2.81),
            
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: bounds.height / 2.6),
            weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor),
            
            imageRainWeatherMiniView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            imageRainWeatherMiniView.leftAnchor.constraint(equalTo: weatherImageView.leftAnchor),
            imageRainWeatherMiniView.rightAnchor.constraint(equalTo: weatherImageView.rightAnchor),
            imageRainWeatherMiniView.heightAnchor.constraint(equalToConstant: bounds.height / 17.6),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    private func setFonts() {
        timeLabel.font = .systemFont(ofSize: bounds.height / 7.125)
        timeLabel.textColor = UIColor(named: "grayTextColor")
        
        temperatureLabel.font = .boldSystemFont(ofSize: bounds.height / 7.125)
    }
}

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
