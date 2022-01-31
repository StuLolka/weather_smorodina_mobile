//
//  MainViews.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit

final class Views {
    
    internal let weatherTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .systemBackground
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
}


extension UIView {
    func setGradientBackground(colorTop: UIColor?, colorBottom: UIColor?) {
        guard let colorBottom = colorBottom, let colorTop = colorTop else {
            print("Color error")
            return
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
