//
//  CurrentCoordinate.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 09.09.2021.
//

import CoreLocation

final class LatitudeLongitude {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

