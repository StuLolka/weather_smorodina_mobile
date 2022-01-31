//
//  HintCitiesCell.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 09.09.2021.
//

import UIKit

final class HintCitiesCell: UICollectionViewCell {
    static let idCell = "idHintCitiesCell"
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "testtesttesttestr"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cityLabel)
        setConstraints()
        setFonts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            cityLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
        ])
    }
    
    private func setFonts() {
        cityLabel.font = .systemFont(ofSize: bounds.height / 2.5)
    }
}
