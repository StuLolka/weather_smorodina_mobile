//
//  MapPinView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 08.09.2021.
//

import MapKit

final class MapPinView: MKAnnotationView {
    var tempMin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 21.05)
        label.textAlignment = .center
        return label
    }()
    
    let tempMax: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 21.05)
        label.textAlignment = .center
        return label
    }()
    
    var sunImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "sun")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var rainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Union")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    func setConstraints() {
        addSubview(tempMin)
        addSubview(tempMax)
        addSubview(sunImage)
        addSubview(mainImage)
        addSubview(rainImage)
        NSLayoutConstraint.activate([
            sunImage.topAnchor.constraint(equalTo: mainImage.topAnchor, constant: -3),
            sunImage.rightAnchor.constraint(equalTo: mainImage.rightAnchor, constant: 3),
            sunImage.heightAnchor.constraint(equalToConstant: (PinSize.size?.width ?? 100) / 2.5),
            sunImage.widthAnchor.constraint(equalTo: sunImage.heightAnchor),
            
            mainImage.widthAnchor.constraint(equalToConstant: (PinSize.size?.width ?? 100) / 2),
            mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor),
            mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            rainImage.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: -5),
            rainImage.rightAnchor.constraint(equalTo: mainImage.rightAnchor, constant: -5),
            rainImage.leftAnchor.constraint(equalTo: mainImage.leftAnchor, constant: 5),
            rainImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            tempMin.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            tempMin.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            tempMax.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            tempMax.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}
