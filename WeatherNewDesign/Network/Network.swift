//
//  Network.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit
import CoreLocation
import Alamofire
import NeedleFoundation

private let urlStringFetchWeather = "http://api.openweathermap.org/data/2.5/forecast?"
private let urlStringCurrentLocation = "http://api.openweathermap.org/data/2.5/weather?"
private let urlStringIP = "http://ip-api.com/json/"

protocol NetworkProtocol {
    
    var currentLocationWeatherByIP: (() -> ())? { get set }
    
    func fetchWeather(city: String, language: String, completion: @escaping (WeatherModel) -> (), loading: @escaping (Float) -> ()?)
    func fetchCurrentLocationWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (CurrentCity) -> ())
    func fetchCurrentLocationWeatherByIP(completion: @escaping(CurrentCityByIP) -> ())
}

final class Network: NetworkProtocol {
    var currentLocationWeatherByIP: (() -> ())?
    
    private var urlFetchWeather: URL? {
        let url = URL(string: urlStringFetchWeather)
        return url
    }
    
    private var urlCurrentLocation: URL? {
        let url = URL(string: urlStringCurrentLocation)
        return url
    }
    
    private var urlIP: URL? {
        let url = URL(string: urlStringIP)
        return url
    }
    
    func fetchWeather(city: String, language: String, completion: @escaping (WeatherModel) -> (), loading: @escaping (Float) -> ()?) {
        let parameters = getParametersInCity(city: city, language: language)
        guard let url = urlFetchWeather else {
            print("URL error in fetchWeather")
            return
        }
        
        //MARK: - download progress, get response and cache
        AF.request(url, parameters: parameters)
            .downloadProgress(closure: { (progress) in
                DispatchQueue.main.async {
                    loading(Float(progress.fractionCompleted))
                }
            })
            .validate()
            .responseDecodable(of: WeatherModel.self) { response in
                guard let weatherModel = self.getWeatherModel(response: response) else {return }
                completion(weatherModel)
            }.resume()
    }
    
    func fetchCurrentLocationWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (CurrentCity) -> ()) {
        
        let parameters = getParametersInCurrentLocation(lat: lat, lon: lon)
        
        guard let url = urlCurrentLocation else {
            currentLocationWeatherByIP?()
            return
        }
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: CurrentCity.self) { response in
                guard let currentCity = self.getResponseCurrentLocationWeather(response: response) else {
                    self.currentLocationWeatherByIP?()
                    return
                }
                completion(currentCity)
            }.resume()
        return
    }
    
    
    func fetchCurrentLocationWeatherByIP(completion: @escaping(CurrentCityByIP) -> ()) {
        guard let url = urlIP else {
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: CurrentCityByIP.self) { response in
                guard let currentCityByIP = self.getResponseCurrentLocationWeatherByIP(response: response) else { return }
                completion(currentCityByIP)
            }.resume()
    }
    
    //MARK:- get response funcs
    private func getWeatherModel(response: DataResponse<WeatherModel, AFError>) -> WeatherModel? {
        guard let data = response.data, response.error == nil, let request = response.request, let responseHTTPURL = response.response, let currentWeather = response.value else {
            print("Decode WeatherModel error")
            return nil
        }
        cachedURLResponse(response: responseHTTPURL, data: data, request: request)
        return currentWeather
    }
    
    private func cachedURLResponse(response: URLResponse, data: Data, request: URLRequest) {
        let cachedURLResponse = CachedURLResponse(response: response, data: data, userInfo: nil, storagePolicy: .allowed)
        URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
    }
    
    private func getResponseCurrentLocationWeather(response: DataResponse<CurrentCity, AFError>) -> CurrentCity? {
        guard response.error == nil else {
            currentLocationWeatherByIP?()
            return nil
        }
        guard let currentWeather = response.value else {
            currentLocationWeatherByIP?()
            return nil
        }
        return currentWeather
    }
    
    private func getResponseCurrentLocationWeatherByIP(response: DataResponse<CurrentCityByIP, AFError>) -> CurrentCityByIP? {
        guard response.error == nil else {
            currentLocationWeatherByIP?()
            return nil
        }
        guard let currentWeather = response.value else {
            return nil
        }
        return currentWeather
    }
    
    //MARK:- parameters funcs
    private func getParametersInCity(city: String, language: String) -> Parameters {
        let parameters: Parameters = ["q": city,
                                      "appid": NetworkProperties.API_KEY,
                                      "lang": language,
                                      "units": "metric"]
        return parameters
    }
    
    private func getParametersInCurrentLocation(lat: CLLocationDegrees, lon: CLLocationDegrees) -> Parameters {
        let parameters: Parameters = ["lat": lat,
                                      "lon": lon,
                                      "appid": NetworkProperties.API_KEY,
                                      "units": "metric"]
        return parameters
    }
}
