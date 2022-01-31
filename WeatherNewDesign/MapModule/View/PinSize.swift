//
//  PinSize.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 09.09.2021.
//

import UIKit

final class PinWidthHeight {
    var width: CGFloat
    var height: CGFloat
    
    init(_ width: CGFloat, _ height: CGFloat) {
        self.width = width
        self.height = height
    }
}

struct PinSize {
    static var size: PinWidthHeight?
}
