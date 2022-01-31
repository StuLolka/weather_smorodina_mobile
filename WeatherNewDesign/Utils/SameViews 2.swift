//
//  MiniView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 17.08.2021.
//

import UIKit

final class SameViews {
    
    internal let miniView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let dateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .center
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
    
    internal let imageWeatherMiniView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.9
        return image
    }()
    
    internal let imageRainWeatherMiniView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.9
        image.image = UIImage(named: "Union")
        image.isHidden = true
        return image
    }()
    
    internal let temperatureMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "--°"
        label.textAlignment = .center
        return label
    }()
    
    internal let feelsLikeMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,----- --- --°"
        label.textAlignment = .center
        return label
    }()
    
    internal let windTextMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Wind"
        label.textAlignment = .center
        return label
    }()
    
    internal let humidityTextMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Humidity"
        label.textAlignment = .center
        return label
    }()
    
    internal let precipitationMiniViewTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Precipitation"
        label.textAlignment = .center
        return label
    }()
    
    internal let windRateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .center
        return label
    }()
    
    internal let humidityRateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .center
        return label
    }()
    
    internal let precipitationRateMiniViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "----,-- ----, --"
        label.textAlignment = .center
        return label
    }()
    
    internal let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.compact.left"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 9.58, left: 12.33, bottom: 9.58, right: 12.33)
        return button
    }()
}
