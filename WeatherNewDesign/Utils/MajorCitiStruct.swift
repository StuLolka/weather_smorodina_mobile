//
//  MajorCitiStruct.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 07.09.2021.
//

import UIKit
import CoreLocation

struct CityCoordinates {
    let city: String
    let coordinates: CLLocationCoordinate2D
    init(_ city: String, _ coordinates: CLLocationCoordinate2D) {
        self.city = city
        self.coordinates = coordinates
    }
}

struct ListMajorCities {
    static var citiesArray: [CityCoordinates] = [
        CityCoordinates("Moscow", CLLocationCoordinate2D(latitude: 55.900136, longitude: 37.518270)),
        CityCoordinates("St. Petersburg", CLLocationCoordinate2D(latitude: 60.124643, longitude: 30.263571)),
        CityCoordinates("St. Petersburg", CLLocationCoordinate2D(latitude: 60.124643, longitude: 30.263571)),
        CityCoordinates("Novosibirsk", CLLocationCoordinate2D(latitude: 55.119935, longitude: 82.899944)),
        CityCoordinates("Yekaterinburg", CLLocationCoordinate2D(latitude: 56.942890, longitude: 60.609120)),
        CityCoordinates("Kazan", CLLocationCoordinate2D(latitude: 55.917591, longitude: 49.126856)),
        CityCoordinates("Nizhny Novgorod", CLLocationCoordinate2D(latitude: 56.360468, longitude: 43.931654)),
        CityCoordinates("Chelyabinsk", CLLocationCoordinate2D(latitude: 55.367679, longitude: 61.365976)),
        CityCoordinates("Omsk", CLLocationCoordinate2D(latitude: 55.068992, longitude: 73.376716)),
        CityCoordinates("Samara", CLLocationCoordinate2D(latitude: 53.441740, longitude: 50.180201)),
        CityCoordinates("Rostov-on-Don", CLLocationCoordinate2D(latitude: 47.347993, longitude: 39.690478)),
        CityCoordinates("Ufa", CLLocationCoordinate2D(latitude: 54.969089, longitude: 56.000493)),
        CityCoordinates("Krasnoyarsk", CLLocationCoordinate2D(latitude: 56.136616, longitude: 92.856115)),
        CityCoordinates("Perm", CLLocationCoordinate2D(latitude: 58.170418, longitude: 56.217776)),
        CityCoordinates("Voronezh", CLLocationCoordinate2D(latitude: 51.830194, longitude: 39.229053)),
        CityCoordinates("Volgograd", CLLocationCoordinate2D(latitude: 48.863785, longitude: 44.505308)),
        CityCoordinates("Krasnodar", CLLocationCoordinate2D(latitude: 45.159024, longitude: 38.999389)),
        CityCoordinates("Saratov", CLLocationCoordinate2D(latitude: 51.670960, longitude: 45.974925)),
        CityCoordinates("Tyumen", CLLocationCoordinate2D(latitude: 57.285839, longitude: 65.533906)),
        CityCoordinates("Tolyatti", CLLocationCoordinate2D(latitude: 53.591953, longitude: 49.405301)),
        CityCoordinates("Izhevsk", CLLocationCoordinate2D(latitude: 56.924487, longitude: 53.168357)),
        CityCoordinates("Barnaul", CLLocationCoordinate2D(latitude: 53.492301, longitude: 83.687781)),
        CityCoordinates("Irkutsk", CLLocationCoordinate2D(latitude: 52.396824, longitude: 104.237626)),
        CityCoordinates("Ulyanovsk", CLLocationCoordinate2D(latitude: 54.454676, longitude: 48.320753)),
        CityCoordinates("Khabarovsk", CLLocationCoordinate2D(latitude: 48.609793, longitude: 135.088014)),
        CityCoordinates("Yaroslavl", CLLocationCoordinate2D(latitude: 57.714784, longitude: 39.889231)),
        CityCoordinates("Vladivostok", CLLocationCoordinate2D(latitude: 43.264583, longitude: 131.971303)),
        CityCoordinates("Makhachkala", CLLocationCoordinate2D(latitude: 43.036107, longitude: 47.484541)),
        CityCoordinates("Tomsk", CLLocationCoordinate2D(latitude: 56.581083, longitude: 84.981160)),
        CityCoordinates("Orenburg", CLLocationCoordinate2D(latitude: 51.923350, longitude: 55.161136)),
        CityCoordinates("Kemerovo", CLLocationCoordinate2D(latitude: 55.462869, longitude: 86.061299)),
        CityCoordinates("Novokuznetsk", CLLocationCoordinate2D(latitude: 53.883768, longitude: 87.184949)),
        CityCoordinates("Ryazan", CLLocationCoordinate2D(latitude: 54.684535, longitude: 39.706234)),
        CityCoordinates("Astrakhan", CLLocationCoordinate2D(latitude: 46.418388, longitude: 48.038646)),
        CityCoordinates("Naberezhnye Chelny", CLLocationCoordinate2D(latitude: 55.760447, longitude: 52.371711)),
        CityCoordinates("Penza", CLLocationCoordinate2D(latitude: 53.285886, longitude: 45.038854)),
        CityCoordinates("Lipetsk", CLLocationCoordinate2D(latitude: 52.682107, longitude: 39.567289)),
        CityCoordinates("Kirov", CLLocationCoordinate2D(latitude: 58.676791, longitude: 49.640048))
    ]
}

struct MajorCityArray {
    static var array = [MajorCity]()
}

struct MajorCity {
    let city: String
    let tempMin: String
    let tempMax: String
    
    let main: String
    let description: String
}


final class GetWeatherListMajorCity {
    let network: NetworkProtocol
    let facade: MapLocationFacade
    
    init(network: NetworkProtocol, facade: MapLocationFacade) {
        self.network = network
        self.facade = facade
    }
    
    func fillArray() {
        var i = 0
        while i < ListMajorCities.citiesArray.count {
            network.fetchWeather(city: ListMajorCities.citiesArray[i].city, language: "eng") { weatherModel in
                var weatherModel = weatherModel
                guard var list = ArrayExtension.getElementFromArray(0, &weatherModel.list) else {return }
                guard let weather = ArrayExtension.getElementFromArray(0, &list.weather) else {return }
                let city = MajorCity(city: weatherModel.city.name,
                                     tempMin: String(Int(list.main.temp_min)),
                                     tempMax: String(Int(list.main.temp_max)),
                                     main: weather.main,
                                     description: weather.description)
                self.facade.addPointToMap(city: city)
                MajorCityArray.array.append(city)
            } loading: { _  in
                
            }
            i += 1
        }
    }
}
