//
//  CustomSearchCell.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 17.08.2021.
//

import UIKit

final class CustomCellSearchTableView: UITableViewCell {
    
    internal lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Мурманск"
        return label
    }()
    
    internal lazy var firstTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "25°"
        return label
    }()
    
    internal lazy var secondTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "25°"
        return label
    }()
    
    internal lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.image = .add
        return weatherImageView
    }()
    
    internal lazy var shadow: UIView = {
        let shadow = UIView()
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.backgroundColor = UIColor(named: "tableViewBackPopUpView")
        shadow.alpha = 0.5
        return shadow
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cityNameLabel)
        addSubview(firstTemperatureLabel)
        addSubview(secondTemperatureLabel)
        addSubview(weatherImageView)
        weatherImageView.addSubview(shadow)
        shadow.isHidden = true
        addConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: bounds.width / 17.15),
            cityNameLabel.rightAnchor.constraint(equalTo: centerXAnchor),
            
            firstTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            firstTemperatureLabel.rightAnchor.constraint(equalTo: secondTemperatureLabel.leftAnchor, constant: -8),
            
            secondTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondTemperatureLabel.rightAnchor.constraint(equalTo: shadow.leftAnchor, constant: -16),
            
            weatherImageView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 3.33),
            weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(bounds.height / 3.33)),
            weatherImageView.widthAnchor.constraint(equalTo: shadow.heightAnchor),
            weatherImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -(bounds.width / 17.15)),
            
            shadow.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            shadow.centerXAnchor.constraint(equalTo: weatherImageView.centerXAnchor),
            shadow.heightAnchor.constraint(equalTo: weatherImageView.heightAnchor),
            shadow.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor),

            
        ])
        
    }
    
    internal func setFonts(view: UITableView) {
        let size = view.bounds.height / 41.68
        cityNameLabel.font = .systemFont(ofSize: size)
        firstTemperatureLabel.font = .systemFont(ofSize: size)
        secondTemperatureLabel.font = .systemFont(ofSize: size)

        
        cityNameLabel.textColor = Theme.currentTheme.text
        firstTemperatureLabel.textColor = Theme.currentTheme.text
        secondTemperatureLabel.textColor = Theme.currentTheme.text
    }
}
