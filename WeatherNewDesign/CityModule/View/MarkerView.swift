//
//  MarkerView.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 23.09.2021.
//

import UIKit
import Charts

class MarkerView: UIView, IMarker {
    var offset: CGPoint
    
    func offsetForDrawing(atPoint: CGPoint) -> CGPoint {
        return CGPoint(x: 30, y: 30)
    }
    
    func refreshContent(entry: ChartDataEntry, highlight: Highlight) {

    }
    
    
    
    func draw(context: CGContext, point: CGPoint) {
        
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    init(offset: CGPoint) {
        self.offset = offset
        super.init(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}
