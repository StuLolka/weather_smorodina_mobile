//
//  Network.swift
//  WeatherNewDesign
//
//  Created by Сэнди Белка on 16.08.2021.
//

import UIKit
import CoreLocation
import Alamofire


class Network {
    
    internal func fetchWeather(city: String, language: String, completion: @escaping (WeatherModel) -> ()) {
        DispatchQueue.main.async {
            let parameters: Parameters = ["q": city,
                                          "appid": NetworkProperties.API_KEY,
                                          "lang": language,
                                          "units": "metric"]

            let urlString = "http://api.openweathermap.org/data/2.5/forecast?"
            guard let url = URL(string: urlString) else {
//                MainWeatherViewController().showAlert(with: NSLocalizedString("networkError", comment: ""), tryAgain: true, city: city)
                print("URL error in fetchWeather")
                return
            }


            //MARK: - download progress, get response and cache
            AF.request(url, parameters: parameters)
                .downloadProgress(closure: { (progress) in
                    DispatchQueue.main.async {
//                        MainWeatherViewController().loading.progress = Float(иprogress.fractionCompleted)
                    }
                })
                .validate().responseJSON { response in
                    switch response.result {
                    case .failure(let error):
//                        MainWeatherViewController().showAlert(with: NSLocalizedString("networkError", comment: ""), tryAgain: true, city: city)
                        print("Validate error in fetchWeather: \(error.localizedDescription)")
                    case .success:
                        break
                    }
                }
                .responseDecodable(of: WeatherModel.self) { response in
                    guard let data = response.data, response.error == nil, let request = response.request, let response = response.response else {return }
                    do {
                        let currentWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
                        completion(currentWeather)
                    } catch {
//                        MainWeatherViewController().showAlert(with: NSLocalizedString("cityNameError", comment: ""), tryAgain: false, city: nil)
                        print("Decode WeatherModel error: \(error.localizedDescription)")
                    }
                    let cachedURLResponse = CachedURLResponse(response: response, data: data, userInfo: nil, storagePolicy: .allowed)
                    URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
                }.resume()
        }
    }

    internal func fetchCurrentLocationWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, view: WeatherView, completion: @escaping (CurrentCity) -> ()) {

        let urlString = "http://api.openweathermap.org/data/2.5/weather?"

        let parameters: Parameters = ["lat": lat,
                                      "lon": lon,
                                      "appid": NetworkProperties.API_KEY,
                                      "units": "metric"]

        guard let url = URL(string: urlString) else {
            view.launchIPRequest()
            return
        }


        AF.request(url, parameters: parameters)
            .validate().responseJSON { response in
                switch response.result {
                case .failure(let error):
                    
                    view.launchIPRequest()
                    print("Validate error in fetchCurrentLocationWeather: \(error.localizedDescription)")
                    return
                case .success:
                    break
                }
            }
            .responseDecodable(of: CurrentCity.self) { response in
                guard response.error == nil, let data = response.data else {
                    view.launchIPRequest()
                    return
                }

                do {
                    let currentCeather = try JSONDecoder().decode(CurrentCity.self, from: data)
                    completion(currentCeather)
                } catch {
                    view.launchIPRequest()
                    print("Decode CurrentCity error: \(error.localizedDescription)")
                }
            }.resume()
        return
    }


    internal func fetchCurrentLocationWeatherByIP(completion: @escaping(CurrentCityByIP) -> ()) {
        let urlString = "http://ip-api.com/json/"
        guard let url = URL(string: urlString) else {
//            MainWeatherViewController().showAlert(with: NSLocalizedString("networkError", comment: ""), tryAgain: true, city: nil)
            return
        }

        AF.request(url)
            .validate().responseJSON { response in
                switch response.result {
                case .failure(let error):
//                    MainWeatherViewController().showAlert(with: NSLocalizedString("networkError", comment: ""), tryAgain: false, city: nil)
                    print("\nValidate fetchCurrentLocationWeatherByIP is failure: \(error.localizedDescription)")
                case .success:
                    break
                }
            }
            .responseDecodable(of: CurrentCityByIP.self) { response in
                guard response.error == nil, let data = response.data else {return }
                do {
                    let currentCeather = try JSONDecoder().decode(CurrentCityByIP.self, from: data)
                    completion(currentCeather)
                } catch {
//                    MainWeatherViewController().showAlert(with: NSLocalizedString("networkError", comment: ""), tryAgain: true, city: nil)
                    print("Decode CurrentCityByIP error: \(error.localizedDescription)")
                }
            }.resume()
    }



}

